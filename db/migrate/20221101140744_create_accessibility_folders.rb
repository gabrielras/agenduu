class CreateAccessibilityFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :accessibility_folders do |t|
      t.references :folder, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :allows

      t.timestamps
    end
  end
end
