class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    # Shared abilities of all signed in users
    if user.persisted?
      can [:index], 'Dashboard'
    end

    if user.is? :admin
      can :manage, :all
    end
  end
end
