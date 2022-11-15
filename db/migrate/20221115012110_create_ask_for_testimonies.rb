class CreateAskForTestimonies < ActiveRecord::Migration[6.1]
  def change
    create_table :ask_for_testimonies do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
