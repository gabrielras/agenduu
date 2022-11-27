class Lead < ApplicationRecord
  belongs_to :organization

  has_one :affiliate_lead, dependent: :destroy
  has_one :affiliate, through: :affiliate_lead

  accepts_nested_attributes_for :affiliate, reject_if: :all_blank, allow_destroy: true

  validates :full_name, presence: true

  validates :email, uniqueness: { scope: :organization_id }
  validates :phone_number, uniqueness: { scope: :organization_id }
end
