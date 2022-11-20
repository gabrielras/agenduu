class CreateAffiliates < ActiveRecord::Migration[6.1]
  def change
    create_table :affiliates do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :client, foreign_key: true

      t.string :key

      t.timestamps
    end
  end
end
