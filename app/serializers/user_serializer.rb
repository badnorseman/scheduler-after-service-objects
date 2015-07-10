class UserSerializer < ActiveModel::Serializer
  include Pundit
  attributes :uid,
             :name,
             :email,
             :can_update,
             :can_delete

  def can_update
    policy(object).update?
  end

  def can_delete
    policy(object).destroy?
  end

  def pundit_user
    scope
  end
end
