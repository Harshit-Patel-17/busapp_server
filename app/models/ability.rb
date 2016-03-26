class Ability
  include CanCan::Ability

  def initialize(user)
    if user != nil
      if user.role[:role_name] == 'admin'
        can :manage, :app
      elsif user.role[:role_name] == 'conductor'
        can :manage, :bus
      end
    end
  end
end
