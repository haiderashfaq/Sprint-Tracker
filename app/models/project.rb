class Project < ApplicationRecord
  belongs_to :company
  sequenceid :company, :projects
  belongs_to :manager, class_name: 'User'
  belongs_to :owner, class_name: 'User'
  validates :name, :manager_id, :owner_id, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }
end
