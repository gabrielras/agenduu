class CreateRatingQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :rating_questions do |t|
      t.integer :value
      t.string :title

      t.timestamps
    end
  end
end
