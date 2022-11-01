class ChangeAttributesTasks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :tasks, :user, index: true, foreign_key: true
    add_reference :tasks, :project, index: true, foreign_key: true
  end
end
