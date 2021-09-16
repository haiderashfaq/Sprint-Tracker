# frozen_string_literal: true

class Issue < ApplicationRecord
  include DateValidations

  sequenceid :company, :issues
  validates :title, length: { minimum: 4, maximum: 255 }
  validates :description, length: { minimum: 6, maximum: 5000 }
  validates :title, :description, :status, :priority, presence: true
  validate_dates :estimated_start_date, :estimated_end_date
  validate_dates :actual_start_date, :actual_end_date

  belongs_to :company
  audited associated_with: :company
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :creator, class_name: 'User'
  belongs_to :reviewer, class_name: 'User', optional: true
  belongs_to :project
  has_many :time_logs, dependent: :destroy
  scope :filter_by_attribute, ->(key, value) { where "#{key}": value }

  STATUS = { Open: 'Open', 'In Progress': 'In Progress', 'Resolved': 'Resolved', 'Closed': 'Closed'}.freeze
  PRIORITY = { Low: 'Low', Medium: 'Medium', High: 'High' }.freeze
  CATEGORY = { Hotfix: 'Hotfix', Feature: :Feature }.freeze
  FILTER = { Assignee: 'assignee', Creator: 'creator', Project: 'project', Status: 'status', Category: 'category', Priority: 'priority', Reviewer: 'reviewer' }.freeze

  def self.time_logs_sum(issue)
    issue.time_logs.sum(:logged_time)
  end

  def self.time_progression(logged_time_sum, issue_estimated_time)
    progress_ratio = [logged_time_sum, issue_estimated_time].min / [logged_time_sum, issue_estimated_time].max
    progress_ratio.to_f * 100
  end
end
