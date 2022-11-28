class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.references :partnership, null: false, foreign_key: true
      t.string :description
      t.string :username

      t.timestamps
    end
  end
end
