class AppointmentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def destroy?
    true
  end

  def done?
    if user.admin
      true
    else
      false
    end
  end

  def appointment?
    true
  end
end
