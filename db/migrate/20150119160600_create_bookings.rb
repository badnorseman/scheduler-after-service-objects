class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user,         index: true
      t.references :coach,        index: true
      t.datetime   :start_at
      t.datetime   :end_at
      t.datetime   :canceled_at
      t.integer    :canceled_by
      t.datetime   :confirmed_at
      t.timestamps
    end
  end
end
