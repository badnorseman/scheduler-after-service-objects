class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string     :name,           null: false, limit: 50
      t.string     :uniquable_name, null: false, limit: 50
      t.timestamps
    end

    add_index :roles, :uniquable_name, unique: true
  end
end
