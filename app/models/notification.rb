class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true

  validates :description, presence: true
  validates :visualized, inclusion: { in: [ true, false ] }
end
