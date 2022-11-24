class Award < ApplicationRecord
  belongs_to :organization
  
  has_many :award_affiliates, dependent: :destroy
  has_many :affiliates,through: :award_affiliates

  validates :business_cell_phone, presence: true
  validates :to_affiliate, presence: true
end
