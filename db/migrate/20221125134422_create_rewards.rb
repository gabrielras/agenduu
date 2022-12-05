class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.references :affiliate, null: false, foreign_key: true
      t.references :lead, null: false, foreign_key: true
      t.references :affiliate_campaign, null: false, foreign_key: true
      t.references :lead_campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
