class Message < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :task

  has_many :mentions, as: :viewer

  accepts_nested_attributes_for :mentions, reject_if: :all_blank, allow_destroy: true

  has_rich_text :description

  validates :send_email, inclusion: { in: [ true, false ] }
end
