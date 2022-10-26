class AddFolderToFolders < ActiveRecord::Migration[6.1]
  def change
    add_reference :folders, :foldable, foreign_key: { to_table: :folders }
  end
end
