class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user,           index: true
      t.string     :first_name,     null: false, limit: 100
      t.string     :last_name,      null: false, limit: 100
      t.string     :company,        limit: 100
      t.string     :address1,       limit: 100
      t.string     :address2,       limit: 100
      t.string     :postal_code,    limit: 20
      t.string     :city,           limit: 100
      t.string     :state_province, limit: 100
      t.string     :country,        limit: 100
      t.string     :phone_number,   limit: 20
      t.string     :gender,         limit: 1
      t.date       :birth_date
      t.integer    :height
      t.integer    :weight
      t.timestamps
    end
  end
end
