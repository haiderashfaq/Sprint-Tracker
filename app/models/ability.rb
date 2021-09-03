# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
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

  end
end