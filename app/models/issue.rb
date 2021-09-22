# frozen_string_literal: true

class Issue < ApplicationRecord
  searchkick word_middle: %i[titile description], filterable: %i[company_id]

  STATUS = { Open: 'Open', 'In Progress': 'In Progress', 'Resolved': 'Resolved', 'Closed': 'Closed' }.freeze
  PRIORITY = { Low: 'Low', Medium: 'Medium', High: 'High' }.freeze
  CATEGORY = { Hotfix: 'Hotfix', Feature: :Feature }.freeze
  FILTER = { Assignee: 'assignee', Creator: 'creator', Project: 'project', Status: 'status', Category: 'category', Priority: 'priority', Reviewer: 'reviewer' }.freeze

  include DateValidations
  include TimeProgressions

  sequenceid :company, :issues
  validates :title, length: { minimum: 4, maximum: 255 }
  validates :description, length: { minimum: 6, maximum: 5000 }
  validates :title, :description, :status, :priority, presence: true
  validate_dates :estimated_start_date, :estimated_end_date
  validate_dates :actual_start_date, :actual_end_date
  scope :filter_by_attribute, ->(key, value) { where "#{key}": value }

  after_save :send_alert

  belongs_to :company
  belongs_to :project
  belongs_to :sprint, optional: true
  audited associated_with: :company
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :reviewer, class_name: 'User', optional: true
  belongs_to :sprint, optional: true
  belongs_to :project, optional: true
  has_many :time_logs, dependent: :destroy
  belongs_to :project
  scope :filter_by_attribute, ->(column, value) { where column => value }

  STATUS = { Open: 'Open', 'In Progress': 'In Progress', 'Resolved': 'Resolved', 'Closed': 'Closed'}.freeze
  PRIORITY = { Low: 'Low', Medium: 'Medium', High: 'High' }.freeze
  CATEGORY = { Hotfix: 'Hotfix', Feature: :Feature }.freeze

  scope :creator, ->(creator) { where creator: creator }
  FILTER = { Assignee: 'assignee', Creator: 'creator', Project: 'project', Status: 'status', Category: 'category', Priority: 'priority', Reviewer: 'reviewer' }.freeze

  def total_spent_time
    time_logs.sum(:logged_time)
  end

  def total_estimated_time
    estimated_time
  end

  def self.get_errors_of_collection(issues)
    errors = []
    issues.each do |issue|
      errors.concat(issue.errors.full_messages)
    end
    errors
  end

  private
  def issue_alert
    users = company.users.where(id: [reviewer_id, assignee_id, creator_id, project.manager_id]).or(company.users.where(role_id: User::ROLE_ID[:admin]))

    subject = I18n.t('issues.email_subject')

    users.each do |user|
      UserMailer.delay.issue_alert(user, self, Company.current_company.subdomain, Current.user, subject, changes)
    end
  end
end
