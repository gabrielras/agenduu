class Reward < ApplicationRecord
  belongs_to :affiliate
  belongs_to :award_history
  belongs_to :lead
end
