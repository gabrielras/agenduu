class RewardLead < ApplicationRecord
  belongs_to :reward
  belongs_to :lead

  validates :reward_story, presence: true
  validates :situation, presence: true
end
