class SubTask < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :task
end
