class Role < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  has_enumeration_for :role_type, with: RoleEnum::RoleTypes, create_helpers: true

  validates :role_type, presence: true
end
