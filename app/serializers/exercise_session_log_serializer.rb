class ExerciseSessionLogSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :started_at,
             :exercise_plan_log_id,
             :exercise_set_logs

  def exercise_set_logs
    object.exercise_set_logs.map do |set_log|
      ExerciseSetLogSerializer.new(set_log, scope: scope, root: false)
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
