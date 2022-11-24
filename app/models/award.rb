class Award < ApplicationRecord
  belongs_to :organization

  validates :business_cell_phone, presence: true
  validates :to_affiliate, presence: true
end
