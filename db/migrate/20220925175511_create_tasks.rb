class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :folder, foreign_key: true
      t.references :creator, foreign_key: { to_table: :users }

      t.string :title
      t.string :link
      t.string :type_task
      t.boolean :send_email

      t.timestamps
    end
  end
end
