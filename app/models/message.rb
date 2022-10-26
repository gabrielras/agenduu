class Message < ApplicationRecord
  belongs_to :task

  has_rich_text :description

  validates :send_email, inclusion: { in: [ true, false ] }
end
