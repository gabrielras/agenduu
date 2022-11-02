class AddProjectToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_reference :notifications, :project, index: true, foreign_key: true
  end
end
