class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
