class CreateExerciseLogs < ActiveRecord::Migration
  def change
    create_table :exercise_logs do |t|
      t.references :user,                 index: true
      t.references :coach,                index: true
      t.references :exercise_description, index: true
      t.references :exercise_set_log,     index: true
      t.decimal    :distance
      t.integer    :duration
      t.decimal    :load
      t.integer    :repetition
      t.string     :tempo,                limit: 8
      t.boolean    :unilateral_loading
      t.boolean    :unilateral_execution
      t.timestamps
    end
  end
end
