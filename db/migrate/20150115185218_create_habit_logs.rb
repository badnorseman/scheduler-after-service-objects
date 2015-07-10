class CreateHabitLogs < ActiveRecord::Migration
  def change
    create_table :habit_logs do |t|
      t.references :habit_description, index: true
      t.references :user,              index: true
      t.text       :logged_at,         limit: 64000
      t.datetime   :ended_at
      t.timestamps
    end
  end
end
