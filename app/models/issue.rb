# frozen_string_literal: true

class Issue < ApplicationRecord
  sequenceid :company, :issues
  validates :title, :description, :status, :priority, presence: true
  self.per_page = 10
  belongs_to :company
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :creator, class_name: 'User'
  belongs_to :reviewer, class_name: 'User', optional: true

  # STATUS = { open: 'open', in_progress: 'in_progress', resolved: 'resolved', closed: 'closed' }
  # PRIORITY = { low: 'low', medium: 'medium', high: 'high'}
  # TYPE = { hotfix: 'hotfix' }
end
