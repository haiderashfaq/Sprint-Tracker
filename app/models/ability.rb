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
      admin_permissions_for_issues(user)
    elsif user.member?
      can :read, User
      member_permissions_for_issues(user)
      member_permissions_for_project(user)
      member_permissions_for_sprint(user)
      creator_permissions_for_issues(user)
      reviewer_permissions_for_issues(user)
      assignee_permissions_for_issues(user)
    end
  end

  def admin_permissions_for_users(user)
    can :manage, User
    unless user.account_owner?
      binding.pry
      cannot %i[edit update destroy], User, id: user.company.owner_id
    end
  end

  def admin_permissions_for_issues(user)
    can :manage, Issue, company_id: user.company_id
  end

  def admin_permissions_for_project
    can %i[read create update destroy], Project
  end

  def admin_permissions_for_sprint
    can %i[read create update destroy], Sprint
  end

  # member permissions
  def member_permissions_for_project(user)
    can %i[read update], Project, manager: user, company_id: user.company_id
  end

  def member_permissions_for_sprint(user)
    can %i[read create update destroy], Sprint, project: { manager: user }
    can :read, Sprint
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
