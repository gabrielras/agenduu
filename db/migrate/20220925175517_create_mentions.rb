
class CreateMentions < ActiveRecord::Migration[6.1]
  def change
    create_table :mentions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :viewer, polymorphic: true

      t.timestamps
    end
  end
end
