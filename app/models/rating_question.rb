class RatingQuestion < ApplicationRecord
  validates :title, presence: true

  validates :value, :inclusion => 1..5
end
