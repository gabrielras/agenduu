class CreateTestimonies < ActiveRecord::Migration[6.1]
  def change
    create_table :testimonies do |t|
      t.references :client, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
