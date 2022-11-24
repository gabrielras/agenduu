class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :awards, dependent: :destroy
  has_many :affiliates, dependent: :destroy
  has_many :rewards, through: :awards
  has_many :clients, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  has_many :invites, dependent: :destroy

  validates :title, presence: true
  validates :phone_number, presence: true

  validates :title, uniqueness: { scope: :organization_id }

  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, presence: true
end
