class AddCreatorToProjects < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :user, index: true, foreign_key: true
  end
end
