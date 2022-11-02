class AccessibilityFolder < ApplicationRecord
  belongs_to :folder
  belongs_to :user

  has_enumeration_for :allows, with: AccessibilityFolderEnum::Allows, create_helpers: true

  validates :allows, presence: true
end
