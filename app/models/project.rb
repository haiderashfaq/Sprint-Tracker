class Project < ApplicationRecord
  belongs_to :company
  sequenceid :company, :projects
  belongs_to :manager, class_name: 'User'
  validates :name, :start_date, :end_date, :manager_id, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }
end
