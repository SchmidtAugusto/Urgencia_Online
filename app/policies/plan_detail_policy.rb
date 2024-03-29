class PlanDetailPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def update?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end
end
