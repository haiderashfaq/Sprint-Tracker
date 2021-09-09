# frozen_string_literal: true

class Issue < ApplicationRecord
  sequenceid :company, :issues
  validates :title, :description, :status, :priority, presence: true

  belongs_to :company
  audited associated_with: :company
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :creator, class_name: 'User'
  belongs_to :reviewer, class_name: 'User', optional: true
  has_many :time_logs

  STATUS = { Open: 'Open', 'In Progress': 'In Progress', 'Resolved': 'Resolved', 'Closed': 'Closed'}.freeze
  PRIORITY = { Low: 'Low', Medium: 'Medium', High: 'High' }.freeze
  CATEGORY = { Hotfix: 'Hotfix', Feature: :Feature }.freeze

  def self.time_logs_sum(issue)
    issue.time_logs.sum(:logged_time)
  end

  def self.time_progression(logged_time_sum, issue_estimated_time)
    progress_ratio = [logged_time_sum, issue_estimated_time].min / [logged_time_sum, issue_estimated_time].max
    progress_ratio.to_f * 100
  end
end
