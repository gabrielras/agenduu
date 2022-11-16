class PinnedLink < ApplicationRecord
  belongs_to :group

  validates :title, presence: true
  validates :link, presence: true
end
