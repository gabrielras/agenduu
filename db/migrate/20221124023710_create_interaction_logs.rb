class CreateInteractionLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :interaction_logs do |t|
      t.references :usable, polymorphic: true
      t.references :organization, null: false, foreign_key: true
      t.string :situation

      t.timestamps
    end
  end
end
