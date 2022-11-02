class AddVisualizedToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :visualized, :boolean, default: false
  end
end
