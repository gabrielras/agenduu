class Invite < ApplicationRecord
  belongs_to :organization

  has_enumeration_for :role_type, with: InviteEnum::RoleTypes, create_helpers: true

  validates :expires_at, presence: true
  validates :role_type, presence: true

  before_create :create_unique_key

  private

  def create_unique_key
    loop do
      self.key = SecureRandom.hex(5)
      break unless self.class.exists?(:key => key)
    end
  end
end
