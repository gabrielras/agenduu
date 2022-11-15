class CreateShareAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :share_awards do |t|
      t.string :key
      t.references :client, null: false, foreign_key: true
      t.references :print_award, null: false, foreign_key: true
      t.boolean :confirmed

      t.timestamps
    end
  end
end
