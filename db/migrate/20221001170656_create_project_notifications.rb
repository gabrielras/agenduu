class CreateProjectNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :project_notifications do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.boolean :receive_email_when_tagged
      t.boolean :receive_email_when_client_responds

      t.timestamps
    end
  end
end
