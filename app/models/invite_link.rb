class InviteLink < ApplicationRecord
  belongs_to :organization
  belongs_to :project, optional: true

  has_enumeration_for :role_type, with: RoleEnum::RoleTypes, create_helpers: true

  validates :expires_at, presence: true
  validates :role_type, presence: true
  validates :key, presence: true

  validate :same_organization, if: [:organization_id, :project_id]

  before_create :create_unique_key

  private

  def create_unique_key
    loop do
      self.key = SecureRandom.hex(5)
      break unless self.class.exists?(:key => key)
    end
  end

  def same_organization
    return if organization.id == project.organization.id

    errors.add(:project, I18n.t('models.concerns.errors.type_is_invalid'))
  end
end