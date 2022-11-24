class CreateAwardHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :award_histories do |t|
      t.references :organization, null: false, foreign_key: true
      t.jsonb :data

      t.timestamps
    end
  end
end
