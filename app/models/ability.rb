# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can [:read, :destroy], User, id: user.id
      can :manage, CleanRequest, user_id: user.id
      if user.staff?
        can :manage, Clean
        can :view, Location
        can :view, Invoice
        can :view, House
        can :view, Extra
      elsif user.admin?
        can :manage, :all
      end
    end
  end
end
