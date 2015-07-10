class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.references :user,                 index: true
      t.references :exercise_set,         index: true
      t.references :exercise_description, index: true
      t.boolean    :distance_selected
      t.decimal    :distance
      t.boolean    :duration_selected
      t.integer    :duration
      t.boolean    :load_selected
      t.decimal    :load
      t.boolean    :repetition_selected
      t.integer    :repetition
      t.integer    :rest
      t.string     :tempo,                 limit: 8
      t.boolean    :unilateral_loading
      t.boolean    :unilateral_execution
      t.timestamps
    end
  end
end
