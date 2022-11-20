class CreateLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :leads do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :origin, polymorphic: true, null: false

      t.string :full_name
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
