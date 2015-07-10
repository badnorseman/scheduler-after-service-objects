class ExerciseSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :distance_selected,
             :distance,
             :duration_selected,
             :duration,
             :load_selected,
             :load,
             :repetition_selected,
             :repetition,
             :rest,
             :tempo,
             :unilateral_loading,
             :unilateral_execution,
             :exercise_description_id

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
