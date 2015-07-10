class ExerciseSetSerializer < ActiveModel::Serializer
  include Pundit
  attributes :id,
             :name,
             :duration,
             :exercises

  def exercises
    object.exercises.map do |set|
      ExerciseSerializer.new(set, scope: scope, root: false)
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
