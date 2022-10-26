class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :clients, dependent: :destroy
  has_many :projects, dependent: :destroy

  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, presence: true

  validates :title, presence: true
  validates :phone_number, presence: true
end
