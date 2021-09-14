# frozen_string_literal: true

class Issue < ApplicationRecord
  sequenceid :company, :issues
  validates :title, length: { minimum: 4 }
  validates :description, length: { minimum: 6 }
  validates :title, :description, :status, :priority, presence: true

  belongs_to :company
  audited associated_with: :company
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :creator, class_name: 'User'
  belongs_to :reviewer, class_name: 'User', optional: true
  belongs_to :project, class_name: 'Project'

  scope :filter_by_status, ->(status) { where status: status }
  scope :filter_by_assignee, ->(assignee) { where assignee: assignee }
  scope :filter_by_category, ->(category) { where category: category }
  scope :filter_by_creator, ->(creator) { where creator: creator }
  scope :filter_by_reviewer, ->(reviewer) { where reviewer: reviewer }
  scope :filter_by_priority, ->(priority) { where priority: priority }
  scope :filter_by_project_id, ->(project_id) {where(@project.sequence_num ==project_id)}
  scope :filter_by_title, ->(title) { where title: title }

  STATUS = { Open: 'Open', 'In Progress': 'In Progress', 'Resolved': 'Resolved', 'Closed': 'Closed'}.freeze
  PRIORITY = { Low: 'Low', Medium: 'Medium', High: 'High' }.freeze
  CATEGORY = { Hotfix: 'Hotfix', Feature: :Feature }.freeze
  FILTER = { Assignee: 'assignee', Creator: 'creator', Project: 'project', Status: 'status', Category: 'category', Priority: 'priority', Reviewer: 'reviewer' }.freeze
end
