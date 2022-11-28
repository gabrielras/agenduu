class CreateRewardAffiliates < ActiveRecord::Migration[6.1]
  def change
    create_table :reward_affiliates do |t|
      t.references :reward, null: false, foreign_key: true
      t.references :affiliate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
