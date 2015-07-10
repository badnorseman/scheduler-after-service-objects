class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user,     index: true
      t.string     :provider, null: false, limit: 50
      t.string     :uid,      null: false, limit: 50
      t.string     :token,    null: false, limit: 100
      t.timestamps
    end

    add_index :identities, [:provider, :uid], unique: true
  end
end
