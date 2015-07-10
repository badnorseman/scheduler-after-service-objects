class CreatePaymentPlans < ActiveRecord::Migration
  def change
    create_table :payment_plans do |t|
      t.references :user,                     index: true
      t.string     :name,                     null: false
      t.text       :description,              null: false, limit: 500
      t.decimal    :price,                    null: false
      t.string     :currency_iso_code,        null: false
      t.string     :billing_day_of_month,     null: false
      t.integer    :number_of_billing_cycles, null: false
      t.integer    :billing_frequency,        null: false
      t.datetime   :ended_at
      t.timestamps
    end
  end
end
