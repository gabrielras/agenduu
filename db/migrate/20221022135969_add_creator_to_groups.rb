class AddCreatorToGroups < ActiveRecord::Migration[6.1]
  def change
    add_reference :group, :creator, index: true, foreign_key: { to_table: :users }
  end
end
