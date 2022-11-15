class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :clients, dependent: :destroy
  has_many :groups, dependent: :destroy

  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  has_many :invites, dependent: :destroy

  validates :title, presence: true
  validates :phone_number, presence: true
  validates :primary_color, presence: true

  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, presence: true
end
