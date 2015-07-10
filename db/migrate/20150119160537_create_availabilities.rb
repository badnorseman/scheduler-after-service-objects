class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.references :coach,                    index: true
      t.datetime   :start_at
      t.datetime   :end_at
      t.time       :beginning_of_business_day
      t.time       :end_of_business_day
      t.integer    :duration
      t.boolean    :auto_confirmation,        default: false
      t.text       :recurring_calendar_days,  default: [], array: true
      t.integer    :cancellation_period
      t.decimal    :late_cancellation_fee
      t.integer    :maximum_of_participants
      t.integer    :priority
      t.timestamps
    end
  end
end
