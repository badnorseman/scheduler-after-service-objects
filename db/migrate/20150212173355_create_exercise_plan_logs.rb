class CreateExercisePlanLogs < ActiveRecord::Migration
  def change
    create_table :exercise_plan_logs do |t|
      t.references :user,    index: true
      t.references :coach,   index: true
      t.string     :name,    null: false, limit: 50
      t.text       :note,    null: false, limit: 500
      t.datetime   :ended_at
      t.timestamps
    end
  end
end
