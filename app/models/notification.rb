class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  validates :description, presence: true
  validates :visualized, inclusion: { in: [ true, false ] }
end
