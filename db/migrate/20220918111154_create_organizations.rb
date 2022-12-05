class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :title
      t.string :state
      t.string :email
      t.string :phone_number
      t.string :primary_color

      t.timestamps
    end

    add_column :organizations, :slug, :string
    add_index :organizations, :slug, unique: true
  end
end
