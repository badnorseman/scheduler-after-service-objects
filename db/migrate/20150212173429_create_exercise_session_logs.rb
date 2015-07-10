class CreateExerciseSessionLogs < ActiveRecord::Migration
  def change
    create_table :exercise_session_logs do |t|
      t.references :user,              index: true
      t.references :coach,             index: true
      t.references :exercise_plan_log, index: true
      t.datetime   :started_at
      t.datetime   :ended_at
      t.timestamps
    end
  end
end
