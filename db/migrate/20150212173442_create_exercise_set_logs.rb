class CreateExerciseSetLogs < ActiveRecord::Migration
  def change
    create_table :exercise_set_logs do |t|
      t.references :user,                 index: true
      t.references :coach,                index: true
      t.references :exercise_session_log, index: true
      t.integer    :duration
      t.integer    :repetition
      t.integer    :rest
      t.timestamps
    end
  end
end
