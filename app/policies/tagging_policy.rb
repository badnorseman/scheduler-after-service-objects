class TaggingPolicy < ApplicationPolicy

  def show?
  end

  def create?
    user.administrator? || user.coach?
  end

  def destroy?
    user.administrator? || user.coach?
  end

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.coach?
        scope.all
      else
        raise Pundit::NotAuthorizedError, "You are not authenticated."
      end
    end
  end
end
