class ExercisePlanSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :description,
             :can_update,
             :can_delete,
             :exercise_sessions

  def exercise_sessions
    object.exercise_sessions.map do |session|
      ExerciseSessionSerializer.new(session, scope: scope, root: false)
    end
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
