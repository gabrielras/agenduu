class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :task, null: false, foreign_key: true

      t.boolean :send_email

      t.timestamps
    end
  end
end
