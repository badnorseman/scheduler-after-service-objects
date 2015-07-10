class ExerciseSetLogSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :duration,
             :repetition,
             :rest,
             :exercise_logs

  def exercise_logs
    object.exercise_logs.map do |set_log|
      ExerciseLogSerializer.new(set_log, scope: scope, root: false)
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
