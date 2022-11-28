class CreatePartnerships < ActiveRecord::Migration[6.1]
  def change
    create_table :partnerships do |t|
      t.references :organization, null: false, foreign_key: true

      t.string :title
      t.string :subtitle
      t.string :description
      t.string :title_form
      t.string :subtitle_form
      t.string :rule_title
      t.string :rule_description
      t.string :background_color
      t.string :primary_color
      t.string :secondary_color

      t.timestamps
    end
  end
end
