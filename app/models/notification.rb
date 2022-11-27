class Notification < ApplicationRecord
  belongs_to :usable, polymorphic: true

  validates :description, presence: true
  validates :visualized, inclusion: { in: [ true, false ] }
end
