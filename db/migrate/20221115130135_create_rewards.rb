class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.references :affiliate, null: false, foreign_key: true
      t.references :print_award, null: false, foreign_key: true

      t.timestamps
    end
  end
end
