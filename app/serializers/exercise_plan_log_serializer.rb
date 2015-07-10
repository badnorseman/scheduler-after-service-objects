class ExercisePlanLogSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :note,
             :can_update,
             :can_delete,
             :exercise_session_logs

  def exercise_session_logs
    object.exercise_session_logs.map do |session_log|
      ExerciseSessionLogSerializer.new(session_log, scope: scope, root: false)
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
