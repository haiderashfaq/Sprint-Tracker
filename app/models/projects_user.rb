class ProjectsUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :project_id, :user_id, presence: true
  validates_uniqueness_of :user_id, scope: :project_id

  def self.create_projects_users(project, users)
    projects_users_attrs = []
    users.each do |user|
      projects_users_attrs << { user: user }
    end
    project.projects_users.create(projects_users_attrs)
  end

  def self.error_messages_and_valid_users(projects_users)
    invalid_users = projects_users.select(&:new_record?)
    errors = []
    invalid_users.each do |projects_user|
      errors << { projects_user.user.email => projects_user.errors.full_messages }
    end
    projects_users.select!(&:persisted?)
    [projects_users, errors]
  end
end
