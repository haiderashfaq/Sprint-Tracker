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

  STATUS = { Open: 'Open', 'In Progress': 'In Progress', 'Resolved': 'Resolved', 'Closed': 'Closed'}.freeze
  PRIORITY = { Low: 'Low', Medium: 'Medium', High: 'High' }.freeze
  CATEGORY = { Hotfix: 'Hotfix', Feature: :Feature }.freeze
  FILTER = { Assignee: 'Assignee', Creator: 'Creator', Project: 'Project', Status: 'Status', Category: 'Category', Priority: 'Priority' }.freeze
end
