class Message < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :task

  has_many :mentions, as: :viewer

  has_rich_text :description

  validates :send_email, inclusion: { in: [ true, false ] }
end
