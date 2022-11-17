class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.references :task, null: false, foreign_key: true
      t.string :description
      t.integer :stars

      t.timestamps
    end
  end
end
