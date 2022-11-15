class RatingAnswer < ApplicationRecord
  belongs_to :star_tag
  belongs_to :task
end
