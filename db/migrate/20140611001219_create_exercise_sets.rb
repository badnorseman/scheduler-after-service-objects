class CreateExerciseSets < ActiveRecord::Migration
  def change
    create_table :exercise_sets do |t|
      t.references :user,             index: true
      t.references :exercise_session, index: true
      t.string     :name,             limit: 50
      t.integer    :duration
      t.timestamps
    end
  end
end
