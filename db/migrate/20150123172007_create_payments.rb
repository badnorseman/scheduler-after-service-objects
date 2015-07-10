class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user,           index: true
      t.references :payment_plan,   index: true
      t.string     :transaction_id, null: false, limit: 50
      t.integer    :customer_id,    null: false
      t.timestamps
    end
  end
end
