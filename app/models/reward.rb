class Reward < ApplicationRecord
  belongs_to :partnership

  has_many :reward_affiliates, dependent: :destroy
  has_many :reward_leads, dependent: :destroy

  validates :description, presence: true
  validates :username, presence: true
end
