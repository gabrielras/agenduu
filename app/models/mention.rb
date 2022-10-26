class Mention < ApplicationRecord
  ALLOWED_VIEWER_TYPES = %w[Task Message].freeze

  belongs_to :user
  belongs_to :viewer, polymorphic: true

  validate :valid_viewer_type, if: [:viewer_type?]

  private

  def valid_viewer_type
    return if ALLOWED_VIEWER_TYPES.include?(viewer_type)

    errors.add(:viewer_type, I18n.t('models.concerns.errors.type_is_invalid'))
  end
end
