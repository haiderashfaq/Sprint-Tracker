class Sprint < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :creator, class_name: 'User'

  sequenceid :project, :sprints
  validates :project_id, :start_date, :end_date, :creator_id, presence: true
end
