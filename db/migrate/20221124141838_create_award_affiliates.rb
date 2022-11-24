class CreateAwardAffiliates < ActiveRecord::Migration[6.1]
  def change
    create_table :award_affiliates do |t|
      t.references :award, null: false, foreign_key: true
      t.references :affiliate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
