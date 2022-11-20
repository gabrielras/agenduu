class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :creator, foreign_key: { to_table: :users }
      t.references :group, foreign_key: true

      t.string :title
      t.string :activity_link
      t.datetime :initial_date
      t.datetime :final_date
      t.integer :interval_to_update
      t.boolean :notified_by_email
      t.boolean :closed

      t.timestamps
    end
  end
end
