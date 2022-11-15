class AddSlugToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :slug, :string
    add_index :tasks, :slug, unique: true

    add_column :group, :slug, :string
    add_index :group, :slug, unique: true
  end
end
