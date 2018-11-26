class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    # Shared abilities of all signed in users
    if user.persisted?
      can :index, 'Dashboard'
      can :index, Team
    end

    if user.is? :admin
      can :manage, :all
    end
  end
end
