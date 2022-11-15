class Rating < ApplicationRecord
  belongs_to :task
  
  has_many :rating_answers, dependent: :destroy

  validates :stars, :inclusion => 1..5
end
