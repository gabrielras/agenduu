class Folder < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :project
  belongs_to :foldable, class_name: 'Folder', optional: true

  has_many :foldables, class_name: 'Folder', foreign_key: 'foldable_id'

  validates :title, presence: true

  validate :valid_foldable, if: [:foldable_id?, :project_id?]

  private

  def valid_foldable
    return if foldable.project_id == project_id

    errors.add(:foldable, I18n.t('models.concerns.errors.type_is_invalid'))
  end
end
