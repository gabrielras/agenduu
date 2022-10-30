class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.references :project, null: false, foreign_key: true
      t.references :creator, foreign_key: { to_table: :users }
      t.string :title

      t.timestamps
    end
  end
end
