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
  validates :phone_number, presence: true

  before_create :create_unique_key
  
  private

  def create_unique_key
    loop do
      self.email_security_key = SecureRandom.hex(5)
      break unless self.class.exists?(email_security_key: email_security_key)
    end
  end
end
