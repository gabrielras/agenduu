class CreateClientAccessibilities < ActiveRecord::Migration[6.1]
  def change
    create_table :client_accessibilities do |t|
      t.references :group, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.timestamps
    end
  end
end
