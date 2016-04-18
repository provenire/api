class Ability
  include CanCan::Ability

  def initialize(user)
    can [:create, :read, :update], :all
    cannot :destroy, :all

    # Users
    can :update, User, id: user.id
    cannot :create, User

    # Pages
    cannot [:create, :update], Page

    # Verbs
    cannot [:create, :update], Verb

    # Versions
    cannot [:create, :update], Version


    # Admin (God Mode Fosho)
    can :manage, :all if user.admin?
  end
end
