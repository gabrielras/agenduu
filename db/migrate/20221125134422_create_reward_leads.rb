class CreateRewardLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :reward_leads do |t|
      t.references :reward, null: false, foreign_key: true
      t.references :lead, null: false, foreign_key: true
      t.jsonb :reward_story

      t.timestamps
    end
  end
end
