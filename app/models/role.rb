class Role < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  has_enumeration_for :role_type, with: RoleEnum::RoleTypes, create_helpers: true

  validates :role_type, presence: true
  validates :user, uniqueness: { scope: :organization_id }

  validate :single_provider, if: [:organization_id, :user_id]

  private

  def single_provider
    if user.decorate.provider.present? && ['owner', 'admin', 'employee'].include?(role_type)
      errors.add(:organization_id, 'Você já tem um cargo em uma organização')
    end
  end
end
