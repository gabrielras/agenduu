class Award < ApplicationRecord
  belongs_to :organization
  
  has_enumeration_for :type_of_award, with: AwardEnum::TypeOfAwards, create_helpers: true

  has_one :modal_award_template, dependent: :destroy
  has_one :page_award_template, dependent: :destroy
  has_one :reward_template, dependent: :destroy

  has_one :award_affiliate, dependent: :destroy
  has_one :affiliate,through: :award_affiliate

  validates :type_of_award, presence: true
  validates :business_cell_phone, presence: true
  validates :to_affiliate, presence: true
  validates :rule, presence: true
end
