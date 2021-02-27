# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :destroy, User, id: user.id
      can :manage, CleanRequest, user_id: user.id
      if user.staff?
        can :manage, Clean
        can :read, Location
        can :read, Invoice
        can :read, House
        can :read, Extra
      elsif user.admin?
        can :manage, :all
      end
    end
  end
end
