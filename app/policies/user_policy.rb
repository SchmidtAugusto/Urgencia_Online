class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def update?
    true
  end

  def admin?
    if user.admin
      true
    else
      false
    end
  end
end
