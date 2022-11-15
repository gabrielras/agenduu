class CreateAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :awards do |t|
      t.references :organization, null: false, foreign_key: true
      t.text :current_client
      t.text :new_client
      t.text :rule
      t.string :business_cell_phone

      t.timestamps
    end
  end
end
