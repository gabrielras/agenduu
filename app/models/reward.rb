class Reward < ApplicationRecord
  belongs_to :affiliate
  belongs_to :print_award

  validates :confirmed, inclusion: { in: [ true, false ] }
end
