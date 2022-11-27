class Affiliate < ApplicationRecord
  #friendly_id :phone_number, use: :slugged

  belongs_to :organization

  has_many :award_affiliates, dependent: :destroy
  has_many :awards,through: :award_affiliates

  has_one :affiliate_lead, dependent: :destroy
  has_one :lead, through: :affiliate_lead

  accepts_nested_attributes_for :lead, reject_if: :all_blank, allow_destroy: true

  validates :full_name, presence: true
  validates :email, presence: true

  validates :email, uniqueness: { scope: :organization_id }
  validates :phone_number, uniqueness: { scope: :organization_id }

  before_create :create_unique_key

  private

  def create_unique_key
    loop do
      self.key = SecureRandom.hex(2)
      break unless self.class.exists?(:key => key)
    end
  end
end
