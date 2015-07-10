class ProfileSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :first_name,
             :last_name,
             :company,
             :address1,
             :address2,
             :postal_code,
             :city,
             :state_province,
             :country,
             :phone_number,
             :gender,
             :birth_date,
             :height,
             :weight,
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
