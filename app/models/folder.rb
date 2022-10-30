class Folder < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :project
  belongs_to :foldable, class_name: 'Folder'

  has_many :foldables, class_name: 'Folder'

  validates :title, presence: true
end
