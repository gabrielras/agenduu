class CreateAffiliateLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :affiliate_leads do |t|
      t.references :affiliate, null: false, foreign_key: true
      t.references :lead, null: false, foreign_key: true

      t.timestamps
    end
  end
end
