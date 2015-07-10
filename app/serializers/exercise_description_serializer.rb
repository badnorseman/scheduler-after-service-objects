class ExerciseDescriptionSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :short_name_for_mobile,
             :description,
             :distance,
             :duration,
             :load,
             :repetition,
             :tempo,
             :video_url,
             :unilateral_execution,
             :unilateral_loading,
             :tag_list,
             :can_update,
             :can_delete

  def load
    object.load
  end

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
