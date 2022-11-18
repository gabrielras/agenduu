class CreateSubTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_tasks do |t|
      t.references :task, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.datetime :initial_date
      t.string :title

      t.timestamps
    end
  end
end
