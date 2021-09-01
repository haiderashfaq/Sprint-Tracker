class Project < ApplicationRecord
  belongs_to :company
  sequenceid :company, :projects
  belongs_to :manager, class_name: 'User'
  validates :name, :start_date, :end_date, :manager_id, presence: true
  self.per_page = 10
end
