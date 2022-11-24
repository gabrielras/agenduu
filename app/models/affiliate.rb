class Affiliate < ApplicationRecord
  friendly_id :title, use: :slugged

  belongs_to :organization

  has_many :awards, dependent: :destroy

  validates :full_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true

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
