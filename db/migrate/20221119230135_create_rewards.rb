class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :type_of_reward
      t.string :social_network
      t.string :username
      t.string :to_affiliate
      t.string :to_lead

      t.timestamps
    end
  end
end
