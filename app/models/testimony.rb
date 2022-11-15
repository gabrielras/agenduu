class Testimony < ApplicationRecord
  belongs_to :client
  belongs_to :group

  has_one_attached :video
end
