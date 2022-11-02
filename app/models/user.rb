class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :roles
  has_many :organizations, through: :roles

  has_many :accessibilities
  has_many :accessibility_notifications
  has_many :mentions
  has_many :notifications
  has_many :previews

  validates :full_name, presence: true
end
