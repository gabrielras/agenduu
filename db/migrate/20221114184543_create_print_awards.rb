class CreatePrintAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :print_awards do |t|
      t.string :current_client
      t.string :new_client
      t.string :rule

      t.timestamps
    end
  end
end
