class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Expense, organization: user.organization
  end
end
