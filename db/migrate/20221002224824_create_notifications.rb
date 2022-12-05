class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :usable, null: false, polymorphic: true

      t.string :description
      t.string :link
      t.boolean :visualized, null: false, default: false

      t.timestamps
    end
  end
end
