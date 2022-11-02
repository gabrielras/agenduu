class TaskFiles < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :task

  has_many_attached :files
end
