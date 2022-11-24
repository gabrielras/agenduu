class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :usable, polymorphic: true

      t.string :description
      t.string :link

      t.timestamps
    end
  end
end
