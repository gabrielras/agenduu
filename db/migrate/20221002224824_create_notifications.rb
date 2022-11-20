class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, foreign_key: true

      t.string :description
      t.string :link

      t.timestamps
    end
  end
end
