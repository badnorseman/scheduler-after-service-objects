class RolePolicy < ApplicationPolicy

  def show?
    user.administrator?
  end

  def create?
    user.administrator?
  end

  def update?
    user.administrator?
  end

  def destroy?
    user.administrator?
  end

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      else
        raise Pundit::NotAuthorizedError, "You are not authenticated."
      end
    end
  end
end
