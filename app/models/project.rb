class Project < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organization
  belongs_to :user, optional: true

  has_many :accessibilities, as: :foldable
  has_many :folders, dependent: :destroy
  has_many :project_notifications, dependent: :destroy
  has_many :users, :through => :accessibilities

  accepts_nested_attributes_for :project_notifications, reject_if: :all_blank, allow_destroy: true

  validates :title, uniqueness: { scope: :organization_id }
  validates :title, presence: true
end
