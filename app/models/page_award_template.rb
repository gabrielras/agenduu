class PageAwardTemplate < ApplicationRecord
  belongs_to :award

  validates :title, presence: true
  validates :description, presence: true
  validates :text_submit, presence: true
  validates :primary_color, presence: true
  validates :secondary_color, presence: true
end
