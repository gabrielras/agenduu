class Role < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  has_enumeration_for :role_type, with: RoleEnum::RoleTypes, create_helpers: true

  validates :role_type, presence: true
  validates :user, uniqueness: { scope: :organization_id }

  validate :single_organization, if: [:organization_id, :user_id]

  private

  def single_organization
    return if user.role.new_record? || user.role.blank?

    errors.add(:organization_id, 'você já tem um cargo')
  end
end
