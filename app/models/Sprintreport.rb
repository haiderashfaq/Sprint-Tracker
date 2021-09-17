class Sprintreport < ApplicationRecord
  belongs_to :sprint
  belongs_to :issue
  belongs_to :company
  belongs_to :moved_to, class_name: 'Sprint', optional: true

  VALID_STATUSES = %w[in_progress closed moved].freeze
  validates :status, inclusion: { in: VALID_STATUSES }
  validates_uniqueness_of :sprint_id, { scope: :issue_id }
end
