class Invitation < ApplicationRecord
  belongs_to :organization
  belongs_to :project, optional: true

  has_enumeration_for :role_type, with: RoleEnum::RoleTypes, create_helpers: true

  validates :expires_at, presence: true
  validates :role_type, presence: true
  validates :key, presence: true
end
