class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
