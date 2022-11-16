class RatingAnswer < ApplicationRecord
  belongs_to :rating_question
  belongs_to :task
end
