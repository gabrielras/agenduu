class CreateTestimonies < ActiveRecord::Migration[6.1]
  def change
    create_table :testimonies do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :client, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
