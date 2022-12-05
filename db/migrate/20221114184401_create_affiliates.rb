class CreateAffiliates < ActiveRecord::Migration[6.1]
  def change
    create_table :affiliates do |t|
      t.references :organization, null: false, foreign_key: true

      t.string :full_name
      t.string :email
      t.string :phone_number

      t.string :key

      t.timestamps
    end

    add_column :affiliates, :slug, :string
    add_index :affiliates, :slug, unique: true
  end
end
