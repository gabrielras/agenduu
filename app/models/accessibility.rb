class Accessibility < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_enumeration_for :allows, with: AccessibilityEnum::Allows, create_helpers: true

  validates :allows, presence: true
end
