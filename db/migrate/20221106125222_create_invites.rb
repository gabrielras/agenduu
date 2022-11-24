class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|
      t.references :organization, null: false, foreign_key: true

      t.string :key
      t.datetime :expires_at

      t.timestamps
    end
  end
end
