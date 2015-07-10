class HabitDescriptionSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :summary,
             :description,
             :tag_list,
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
