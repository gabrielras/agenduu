class Partnership < ApplicationRecord
  belongs_to :organization

  validates :title, length: { minimum: 5, maximum: 80 }, allow_blank: true
  validates :subtitle, length: { minimum: 5, maximum: 80 }, allow_blank: true
  validates :description, length: { minimum: 5, maximum: 80 }, allow_blank: true
  validates :title_form, length: { minimum: 5, maximum: 80 }, allow_blank: true
  validates :subtitle_form, length: { minimum: 5, maximum: 80 }, allow_blank: true
  validates :rule_title, length: { minimum: 5, maximum: 80 }, allow_blank: true
  validates :rule_description, length: { minimum: 5, maximum: 80 }, allow_blank: true

  validates :title, presence: true
  validates :subtitle, presence: true
  validates :description, presence: true

  validates :title_form, presence: true
  validates :subtitle_form, presence: true

  validates :rule_title, presence: true
  validates :rule_description, presence: true, if: :rule_title
end
