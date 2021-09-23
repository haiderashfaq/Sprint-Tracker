class Sprintreport < ApplicationRecord
  belongs_to :sprint
  belongs_to :issue
  belongs_to :company
  belongs_to :moved_to, class_name: 'Sprint', optional: true

  STATUS = { IN_PROGRESS: IN_PROGRESS, CLOSED: CLOSED, MOVED: MOVED }.freeze
  validates :status, inclusion: { in: STATUS.values }
  validates_uniqueness_of :sprint_id, { scope: :issue_id }

end
