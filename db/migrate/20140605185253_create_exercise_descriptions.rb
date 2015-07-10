class CreateExerciseDescriptions < ActiveRecord::Migration
  def change
    create_table :exercise_descriptions do |t|
      t.references :user,                  index: true
      t.string     :name,                  null: false, limit: 50
      t.string     :uniquable_name,        null: false, limit: 50
      t.string     :short_name_for_mobile, null: false, limit: 25
      t.text       :description,           null: false, limit: 500
      t.boolean    :distance
      t.boolean    :duration
      t.boolean    :load
      t.boolean    :repetition
      t.string     :tempo,                 limit: 8
      t.boolean    :unilateral_execution
      t.boolean    :unilateral_loading
      t.string     :video_url,             limit: 100
      t.datetime   :ended_at
      t.timestamps
    end

    add_index :exercise_descriptions, [:user_id, :uniquable_name], unique: true
  end
end
