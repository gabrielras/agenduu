class CreateAccessibilities < ActiveRecord::Migration[6.1]
  def change
    create_table :accessibilities do |t|
      t.references :foldable, polymorphic: true
      t.references :user, null: false, foreign_key: true

      t.string :allows

      t.timestamps
    end
  end
end
