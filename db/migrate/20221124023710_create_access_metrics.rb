class CreateAccessMetrics < ActiveRecord::Migration[6.1]
  def change
    create_table :access_metrics do |t|
      t.references :usable, polymorphic: true
      t.references :organization, null: false, foreign_key: true
      t.string :situation
      t.jsonb :data

      t.timestamps
    end
  end
end
