class CreateLeadCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :lead_campaigns do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :affiliate_campaign, foreign_key: true

      t.string :title
      t.string :subtitle
      t.string :description
      t.string :rule_description
      t.string :background_color
      t.string :primary_color
      t.string :secondary_color

      t.timestamps
    end
  end
end
