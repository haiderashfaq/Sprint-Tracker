class ProjectsUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates_uniqueness_of :user_id, { scope: :project_id, message: I18n.t('users.duplicate_error') }
  before_destroy :check_user_responsibilities

  def self.create_projects_users(project, user_ids)
    projects_users_attrs = []
    user_ids.each do |user_id|
      projects_users_attrs << { user_id: user_id }
    end
    project.projects_users.create(projects_users_attrs)
  end

  def self.error_messages_and_valid_users(projects_users)
    invalid_users = projects_users.select(&:new_record?)
    errors = []
    invalid_users.each do |projects_user|
      errors << projects_user.errors.full_messages
    end
    projects_users.select!(&:persisted?)
    [projects_users, errors]
  end

  def self.add_projects_users(project, user_ids)
    projects_users = create_projects_users(project, user_ids)
    error_messages_and_valid_users(projects_users)
  end

  private

  def check_user_responsibilities
    return unless Issue.where(assignee_id: user_id).or(Issue.where(reviewer_id: user_id)).blank?

    errors.add(base: I18n.t('users.project_user_destroy_error'))
    throw :abort
  end
end
