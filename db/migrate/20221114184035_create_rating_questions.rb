class CreateRatingQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :rating_questions do |t|
      t.references :organization, null: false, foreign_key: true
      t.integer :value
      t.string :title

      t.timestamps
    end
  end
end
