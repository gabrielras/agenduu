class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.references :taskable, polymorphic: true
      t.datetime :execution_date
      t.integer :days_to_make_mandatory
      t.boolean :repeat, default: false, null: false
      t.integer :interval_repeat, null: false
      t.integer :day_of_repeat, null: false
      t.integer :minute_of_repeat, null: false
      t.integer :hour_of_repeat, null: false

      t.timestamps
    end
  end
end
