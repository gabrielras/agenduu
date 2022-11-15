class Group < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organization
  belongs_to :creator, class_name: 'User', optional: true

  has_many :accessibilities, dependent: :destroy
  has_many :users, :through => :accessibilities
  has_many :tasks, dependent: :destroy
  has_many :invites, dependent: :destroy

  validates :title, uniqueness: { scope: :organization_id }
  validates :title, presence: true
end
