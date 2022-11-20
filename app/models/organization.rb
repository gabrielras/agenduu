class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one :ask_for_testimony, dependent: :destroy
  has_many :testimonies, dependent: :destroy

  has_one :award, dependent: :destroy
  has_many :rewards, through: :award

  has_many :affiliates, dependent: :destroy

  has_many :clients, dependent: :destroy
  has_many :groups, dependent: :destroy

  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  has_many :invites, dependent: :destroy

  validates :title, presence: true
  validates :phone_number, presence: true

  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, presence: true
end
