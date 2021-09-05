# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    return if user.nil?

    if user.admin?
      admin_permissions_for_project
      admin_permissions_for_issues
    elsif user.member?
      member_permissions_for_issues(user)
      member_permissions_for_project(user)
      creator_permissions_for_issues(user)
      reviewer_permissions_for_issues(user)
      assignee_permissions_for_issues(user)
      can :create, Project
    end
  end

  def admin_permissions_for_issues
    can :manage, Issue
  end

  def admin_permissions_for_project
    can %i[update read create delete], Project
  end

  def member_permissions_for_project(user)
    can %i[read update], Project, manager: user
  end

  def creator_permissions_for_issues(user)
    can %i[create update destroy], Issue, creator: user
  end

  def reviewer_permissions_for_issues(user)
    can [:read], Issue, reviewer: user
  end

  def assignee_permissions_for_issues(user)
    can %i[read update], Issue, creator: user
  end

  def member_permissions_for_issues(user)
    can :create, Issue if user.company_id == Company.current_company.id
  end

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
  #
  # See the wiki for details:
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
end
