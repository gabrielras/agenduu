class CreateRatingAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :rating_answers do |t|
      t.references :star_tag, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
