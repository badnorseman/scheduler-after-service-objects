class PaymentPolicy < ApplicationPolicy

  def show?
    user.administrator? || user.id == record.user_id
  end

  def create?
    show?
  end

  def update?
    user.administrator?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      if user.administrator?
        scope.all
      elsif user.id
        scope.where(user_id: user.id)
      else
        raise Pundit::NotAuthorizedError, "You are not authenticated."
      end
    end
  end
end
