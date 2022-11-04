class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :project, foreign_key: true
      t.string :key
      t.string :email
      t.string :role_type
      t.string :state
      t.datetime :expires_at

      t.timestamps
    end
  end
end
