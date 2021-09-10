class Project < ApplicationRecord
  belongs_to :company
  belongs_to :manager, class_name: 'User'
  belongs_to :creator, class_name: 'User'

  # validate :start_date_before_end_date
  validates :name, :manager_id, :creator_id, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }
  has_many :issues


  has_many :sprints

  include DateValidations
  sequenceid :company, :projects
  validates :name, :manager_id, :creator_id, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }
  validate_dates :start_date, :end_date
end
