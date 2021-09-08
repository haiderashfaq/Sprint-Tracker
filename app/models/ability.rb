# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, options = {})
    return if user.nil?

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true

    if user.admin?
      admin_permissions_for_project
      admin_permissions_for_sprint
      admin_permissions_for_projects_users
    elsif user.member?
      member_permissions_for_project(user)
      member_permissions_for_sprint(user)
      member_permissions_for_projects_users(user)
    end
  end

  # admin permissions
  def admin_permissions_for_project
    can %i[read create update delete destroy], Project
  end

  def admin_permissions_for_sprint
    can %i[read create update delete destroy], Sprint
  end

  def admin_permissions_for_projects_users
    can %i[read create delete destroy], ProjectsUser
  end

  # member permissions
  def member_permissions_for_project(user)
    can %i[read update], Project, manager: user
    can :read, Project, projects_users: { user: user }
  end

  def member_permissions_for_sprint(user)
    can %i[read create update delete destroy], Sprint, project: { manager: user }
    can :read, Sprint
  end

  def member_permissions_for_projects_users(user)
    can %i[read create update delete destroy], ProjectsUser, project: { manager: user }
    can :read, ProjectsUser
  end
end
