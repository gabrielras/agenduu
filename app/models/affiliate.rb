class Affiliate < ApplicationRecord
  belongs_to :organization
  belongs_to :client, optional: true
  
  has_one :lead, as: :origin

  before_create :create_unique_key

  private

  def create_unique_key
    loop do
      self.key = SecureRandom.hex(4)
      break unless self.class.exists?(:key => key)
    end
  end
end
