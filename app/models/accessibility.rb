class Accessibility < ApplicationRecord
  belongs_to :group
  belongs_to :user

  has_enumeration_for :allow, with: AccessibilityEnum::Allows, create_helpers: true

  validates :allow, presence: true
end
