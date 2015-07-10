class CreateHabits < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.references :habit_description, index: true
      t.references :product,           index: true
      t.string     :unit,              null: false, limit: 50
      t.decimal    :size
      t.integer    :user_id
      t.timestamps
    end
  end
end
