class TaskFiles < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :task

  has_one_attached :file
end
