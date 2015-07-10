class UserPolicy < ApplicationPolicy

  def show?
    user.administrator? || user.id == record.id
  end

  def create?
    user.administrator?
  end

  def update?
    show?
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
