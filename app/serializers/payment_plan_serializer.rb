class PaymentPlanSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :description,
             :price,
             :currency_iso_code,
             :billing_day_of_month,
             :number_of_billing_cycles,
             :billing_frequency,
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
