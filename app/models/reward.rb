class Reward < ApplicationRecord
  belongs_to :organization

  has_many :reward_affiliates, dependent: :destroy
  has_many :reward_leads, dependent: :destroy

  has_enumeration_for :type_of_reward, with: RewardEnum::TypesOfReward, create_helpers: true
  has_enumeration_for :social_network, with: RewardEnum::SocialNetworks, create_helpers: true

  validates :to_affiliate, length: { minimum: 5, maximum: 60 }, allow_blank: true
  validates :to_lead, length: { minimum: 5, maximum: 60 }, allow_blank: true

  validates :to_affiliate, presence: true
  validates :to_lead, presence: true

  validates :type_of_reward, presence: true
  validates :social_network, presence: true
  validates :username, presence: true
end
