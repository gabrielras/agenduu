class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
