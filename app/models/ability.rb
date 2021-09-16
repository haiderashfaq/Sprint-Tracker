# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    return if user.nil?

    if user.admin?
      admin_permissions_for_users(user)
      admin_permissions_for_project
      admin_permissions_for_sprint
      admin_permissions_for_projects_users
      admin_permissions_for_issues(user)
    elsif user.member?
      can :read, User
      member_permissions_for_issues(user)
      member_permissions_for_project(user)
      member_permissions_for_sprint(user)
      member_permissions_for_projects_users(user)
      creator_permissions_for_issues(user)
      reviewer_permissions_for_issues(user)
      assignee_permissions_for_issues(user)
    end
  end

  def admin_permissions_for_users(user)
    can :manage, User
    unless user.account_owner?
      cannot %i[edit update destroy], User, id: user.company.owner_id
    end
  end

  def admin_permissions_for_issues(user)
    can :manage, Issue, company_id: user.company_id
  end

  def admin_permissions_for_project
    can :manage, Project
  end

  def admin_permissions_for_sprint
    can :manage, Sprint
  end

  def admin_permissions_for_projects_users
    can %i[read create destroy], ProjectsUser
  end

  # member permissions
  def member_permissions_for_project(user)
    can %i[read update], Project, manager: user, company_id: user.company_id
    can :read, Project, projects_users: { user: user }
  end

  def member_permissions_for_sprint(user)
    can %i[read create update destroy], Sprint, project: { manager: user }
    can :read, Sprint, project: { projects_users: user }
  end

  def member_permissions_for_projects_users(user)
    can %i[read create update destroy], ProjectsUser, project: { manager: user }
    can :read, ProjectsUser
  end

  def creator_permissions_for_issues(user)
    can %i[read update destroy], Issue, creator: user, company_id: user.company_id
  end

  def reviewer_permissions_for_issues(user)
    can [:read], Issue, reviewer: user, company_id: user.company_id
  end

  def assignee_permissions_for_issues(user)
    can %i[read update], Issue, creator: user, company_id: user.company_id
  end

  def member_permissions_for_issues(user)
    can :create, Issue, company_id: user.company_id
  end
end
