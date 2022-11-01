class AddAllowClientsTaskToFolders < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :allow_clients_task, :boolean
  end
end
