class CreateTaskFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :task_files do |t|
      t.references :task, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
