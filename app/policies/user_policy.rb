class UserPolicy < ApplicationPolicy
  def show?
    return true
  end

  def create?
    return true
  end

  def update?
    return true if user.admin?
  end

  def destroy?
    return true if user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
