class AskForTestimony < ApplicationRecord
  belongs_to :organization

  validates :title, presence: true
  validates :description, presence: true
end
