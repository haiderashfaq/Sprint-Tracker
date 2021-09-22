# frozen_string_literal: true

class Issue < ApplicationRecord
  STATUS = { Open: 'Open', 'In Progress'.to_sym=> 'In Progress', 'Resolved': 'Resolved', 'Closed': 'Closed' }.freeze
  PRIORITY = { Low: 'Low', Medium: 'Medium', High: 'High' }.freeze
  CATEGORY = { Hotfix: 'Hotfix', Feature: :Feature }.freeze
  FILTER = { Assignee: 'assignee', Creator: 'creator', Project: 'project', Status: 'status', Category: 'category', Priority: 'priority', Reviewer: 'reviewer' }.freeze
  CLOSED = 'Closed'
  searchkick word_middle: %i[titile description]
  include DateValidations

  belongs_to :company
  belongs_to :project, optional: true
  belongs_to :sprint, optional: true
  audited associated_with: :company
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :reviewer, class_name: 'User', optional: true
  has_many :time_logs, dependent: :destroy

  sequenceid :company, :issues
  validates :title, length: { minimum: 4, maximum: 255 }
  validates :description, length: { minimum: 6, maximum: 5000 }
  validates :title, :description, :status, :priority, presence: true
  validate_dates :estimated_start_date, :estimated_end_date
  validate_dates :actual_start_date, :actual_end_date
  scope :filter_by_attribute, ->(key, value) { where "#{key}": value }

  def total_time_spent
    time_logs.sum(:logged_time)
  end

  def self.time_progression(logged_time_sum, issue_estimated_time)
    progress_ratio = [logged_time_sum, issue_estimated_time].min / [logged_time_sum, issue_estimated_time].max
    progress_ratio.to_f * 100
  end

  def self.get_errors_of_collection(issues)
    errors = []
    issues.each do |issue|
      errors.concat(issue.errors.full_messages)
    end
    errors
  end

  def assignee_name
    if(assignee.present?)
      assignee.name
    else
      I18n.t 'issues.no_assignee'
    end
  end
end
