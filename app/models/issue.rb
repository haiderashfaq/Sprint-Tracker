# frozen_string_literal: true

class Issue < ApplicationRecord
  searchkick word_middle: %i[titile description], filterable: %i[company_id]

  STATUS = { open: 'Open', in_progress: 'In Progress', resolved: 'Resolved', closed: 'Closed' }.freeze
  PRIORITY = { low: 'Low', medium: 'Medium', high: 'High' }.freeze
  CATEGORY = { hotfix: 'Hotfix', feature: :Feature }.freeze
  FILTER = { Assignee: 'assignee', Creator: 'creator', Project: 'project', Status: 'status', Category: 'category', Priority: 'priority', Reviewer: 'reviewer' }.freeze

  include DateValidations
  include TimeProgressions

  belongs_to :company
  belongs_to :project
  belongs_to :sprint, optional: true
  audited associated_with: :company
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :reviewer, class_name: 'User', optional: true
  has_many :time_logs, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  sequenceid :company, :issues

  validates :title, length: { minimum: 4, maximum: 255 }
  validates :description, length: { minimum: 6, maximum: 5000 }
  validates :title, :description, :status, :priority, presence: true
  validate_datetime :actual_end_date
  validate_datetime :actual_start_date
  validate_datetime :estimated_end_date
  validate_datetime :estimated_start_date
  validates :estimated_time, length: { maximum: 100 }, numericality: { greater_than: 0 }
  validate_dates :estimated_start_date, :estimated_end_date
  validate_dates :actual_start_date, :actual_end_date
  scope :filter_by_attribute, ->(column, value) { where column => value }
  scope :creator, ->(creator) { where creator: creator }

  sequenceid :company, :issues
  audited associated_with: :company

  after_save :issue_alerts

  def total_time_spent
    time_logs.sum(:logged_time)
  end

   def assignee_name
    assignee&.name || I18n.t('issues.no_assignee')
   end

  def total_estimated_time
    @issues&.sum(estimated_time) || estimated_time
  end

  def self.get_errors_of_collection(issues)
    errors = []
    issues.each do |issue|
      errors.concat(issue.errors.full_messages)
    end
    errors
  end

  def self.users_name(ids)
    user_name = []
    user_name[0] = User.find_by(id: ids[0].to_i)&.name || I18n.t('shared.no_resource_found', resource_label: 'user')
    user_name[1] = User.find_by(id: ids[1].to_i)&.name || I18n.t('shared.no_resource_found', resource_label: 'user')
    user_name
  end

  private
  def issue_alerts
    return if previous_changes.empty?

    users = company.users.where(id: [reviewer_id, assignee_id, creator_id, project.manager_id]).or(company.users.where(role_id: User::ROLE_ID[:admin]))

    subject = I18n.t('issues.email_subject')

    users.each do |user|
      UserMailer.delay.issue_alerts(user, self, Company.current_company.subdomain, Current.user, subject, previous_changes)
    end
  end
end
