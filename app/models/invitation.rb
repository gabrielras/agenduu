class Invitation < ApplicationRecord
  belongs_to :organization
  belongs_to :project, optional: true

  has_enumeration_for :role_type, with: RoleEnum::RoleTypes, create_helpers: true
  has_enumeration_for :state, with: InvitationEnum::States, create_helpers: true

  validates :state, presence: true
  validates :expires_at, presence: true
  validates :role_type, presence: true
  validates :key, presence: true

  before_create :create_unique_key

  private

  def create_unique_key
    loop do
      self.key = SecureRandom.hex(5)
      break unless self.class.exists?(:key => key)
    end
  end
end
