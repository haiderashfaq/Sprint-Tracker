# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
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