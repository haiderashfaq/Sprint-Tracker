class Sprint < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :creator, class_name: 'User'

  include DateValidations
  sequenceid :project, :sprints
  validates :project_id, :start_date, :end_date, :creator_id, presence: true
  validate_dates :start_date, :end_date
  validate_dates :estimated_start_date, :estimated_end_date
end
