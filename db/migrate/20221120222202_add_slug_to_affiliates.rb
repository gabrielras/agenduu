class AddSlugToAffiliates < ActiveRecord::Migration[6.1]
  def change
    add_column :affiliates, :slug, :string
    add_index :affiliates, :slug, unique: true
  end
end
