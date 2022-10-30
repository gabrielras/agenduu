class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :task, null: false, foreign_key: true
      t.references :creator, foreign_key: { to_table: :users }

      t.boolean :send_email

      t.timestamps
    end
  end
end
