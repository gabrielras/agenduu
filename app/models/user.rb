class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :role
  has_one :organization, through: :role

  has_many :accessibilities
  has_many :mentions
  has_many :notifications

  validates :full_name, presence: true
  validates :phone_number, presence: true
end
