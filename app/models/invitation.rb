class Invitation < ApplicationRecord
  belongs_to :organization
  belongs_to :project, optional: true

  has_enumeration_for :role_type, with: RoleEnum::RoleTypes, create_helpers: true
  has_enumeration_for :state, with: InvitationEnum::States, create_helpers: true

  validates :email, presence: true
  validates :expires_at, presence: true
  validates :role_type, presence: true
  validates :state, presence: true

  validate :same_organization, if: [:organization_id, :project_id]
  validate :unique_email, if: [:email, :organization_id]

  private

  def same_organization
    return if organization.id == project.organization.id

    errors.add(:project, I18n.t('models.concerns.errors.type_is_invalid'))
  end

  def unique_email
    return if Invitation.where(email: email, project: project, organization: organization).blank?

    errors.add(:email, 'deve ser único')
  end
end
