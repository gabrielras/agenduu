class CreateStarTags < ActiveRecord::Migration[6.1]
  def change
    create_table :star_tags do |t|
      t.references :organization, null: false, foreign_key: true
      t.integer :value
      t.string :title

      t.timestamps
    end
  end
end
