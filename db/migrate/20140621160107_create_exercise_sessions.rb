class CreateExerciseSessions < ActiveRecord::Migration
  def change
    create_table :exercise_sessions do |t|
      t.references :user,          index: true
      t.references :exercise_plan, index: true
      t.string     :name,          limit: 50
      t.timestamps
    end
  end
end
