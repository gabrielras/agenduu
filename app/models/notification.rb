class Notification < ApplicationRecord
  belongs_to :user

  validates :description, presence: true
  validates :visualized, inclusion: { in: [ true, false ] }
end
