class CreateAccessibilityNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :accessibility_notifications do |t|
      t.references :accessibility, null: false, foreign_key: true

      t.boolean :receive_email_when_tagged, null: false, default: false
      t.boolean :receive_email_when_responds, null: false, default: false

      t.timestamps
    end
  end
end
