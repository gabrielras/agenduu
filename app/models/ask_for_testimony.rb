class AskForTestimony < ApplicationRecord
  belongs_to :organization

  has_many :testimonies, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
