class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :user,           index: true
      t.string     :name,           null: false, limit: 50
      t.string     :uniquable_name, null: false, limit: 50
      t.datetime   :ended_at
      t.timestamps
    end

    add_index :tags, :uniquable_name, unique: true
  end
end
