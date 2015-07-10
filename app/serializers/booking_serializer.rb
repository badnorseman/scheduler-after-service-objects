class BookingSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :start_at,
             :end_at,
             :canceled_at,
             :canceled_by,
             :confirmed_at,
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
