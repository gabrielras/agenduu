class AddSlugToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :slug, :string
    add_index :tasks, :slug, unique: true

    add_column :projects, :slug, :string
    add_index :projects, :slug, unique: true
  end
end
