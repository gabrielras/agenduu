class RatingQuestion < ApplicationRecord
  belongs_to :organization

  validates :title, presence: true

  validates :value, :inclusion => 1..5
end
