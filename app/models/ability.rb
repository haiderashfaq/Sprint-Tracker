# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    return if user.nil?
    if user.account_owner?
      can :manage, User
      admin_permissions_for_project(user)
      admin_permissions_for_issues(user)

    elsif user.admin?
      can :manage, User
      cannot :manage, User, id: user.company.owner_id
      admin_permissions_for_project(user)
      admin_permissions_for_issues(user)
    elsif user.member?
      can :read, User
      member_permissions_for_issues(user)
      member_permissions_for_project(user)
      creator_permissions_for_issues(user)
      reviewer_permissions_for_issues(user)
      assignee_permissions_for_issues(user)
      can :create, Project
    end
  end

  def admin_permissions_for_issues(user)
    can :manage, Issue, company_id: user.company_id
  end

  def admin_permissions_for_project(user)
    can %i[update read create delete], Project, company_id: user.company_id
  end

  def member_permissions_for_project(user)
    can %i[read update], Project, manager: user, company_id: user.company_id
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
