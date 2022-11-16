class Invite < ApplicationRecord
  belongs_to :organization
  belongs_to :group, optional: true

  validates :expires_at, presence: true
  validates :key, presence: true

  validate :same_organization, if: [:organization_id, :group_id]

  before_create :create_unique_key

  private

  def create_unique_key
    loop do
      self.key = SecureRandom.hex(5)
      break unless self.class.exists?(:key => key)
    end
  end

  def same_organization
    return if organization.id == group.organization.id

    errors.add(:group, I18n.t('models.concerns.errors.type_is_invalid'))
  end
end
