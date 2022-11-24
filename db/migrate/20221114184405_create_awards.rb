class CreateAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :awards do |t|
      t.references :organization, null: false, foreign_key: true

      t.string :to_affiliate
      t.string :to_lead
      t.string :rule
      t.string :business_cell_phone

      t.timestamps
    end
  end
end
