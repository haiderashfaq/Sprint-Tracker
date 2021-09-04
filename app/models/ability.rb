# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    binding.pry
    return if user.nil?

    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)
    if user.account_owner?
      can :manage, User

    elsif user.admin?
      can :manage, User
      cannot :manage, User, id: user.company.owner_id
    end

    if user.member?
      can :read, User
    end

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
    elsif user.member?
      member_permissions_for_project(user)
    end
  end

  def admin_permissions_for_project
    can %i[update read create delete], Project
  end

  def member_permissions_for_project(user)
    can %i[read update], Project, manager: user
  end
end