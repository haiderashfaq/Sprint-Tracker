class ProjectsUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :project_id, :user_id, presence: true
  validates_uniqueness_of :user_id, scope: :project_id
end
