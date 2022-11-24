class CreateAwardTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :award_templates do |t|
      t.references :award, null: false, foreign_key: true
      t.string :template_type
      t.string :title
      t.string :description
      t.string :text_submit
      t.string :primary_color
      t.string :secondary_color

      t.timestamps
    end
  end
end
