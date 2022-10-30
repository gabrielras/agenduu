class Accessibility < ApplicationRecord
  ALLOWED_FOLDABLE_TYPES = %w[Project].freeze

  belongs_to :foldable, polymorphic: true
  belongs_to :user

  has_enumeration_for :allows, with: AccessibilityEnum::Allows, create_helpers: true

  validates :allows, presence: true

  validate :valid_foldable_type, if: [:foldable_type?]

  private

  def valid_foldable_type
    return if ALLOWED_FOLDABLE_TYPES.include?(foldable_type)

    errors.add(:foldable_type, I18n.t('models.concerns.errors.type_is_invalid'))
  end
end
