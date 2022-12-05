class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one :affiliate_campaign, dependent: :destroy

  has_many :affiliates, dependent: :destroy
  has_many :leads, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  has_many :invites, dependent: :destroy

  validates :title, presence: true
  validates :phone_number, presence: true

  validates :title, uniqueness: true

  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, presence: true
end
