class AwardHistory < ApplicationRecord
  belongs_to :organization

  validates :data, presence: true
end
