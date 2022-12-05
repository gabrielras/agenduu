class CreateCallToActions < ActiveRecord::Migration[6.1]
  def change
    create_table :call_to_actions do |t|
      t.references :action, polymorphic: true
      t.string :link
      t.string :social_network
      t.string :username
      t.text :message

      t.timestamps
    end
  end
end
