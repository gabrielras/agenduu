class CreatePinnedLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :pinned_links do |t|
      t.references :group, null: false, foreign_key: true
      t.string :link
      t.string :title

      t.timestamps
    end
  end
end
