class ExerciseSessionSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :exercise_sets

  def exercise_sets
    object.exercise_sets.map do |set|
      ExerciseSetSerializer.new(set, scope: scope, root: false)
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
