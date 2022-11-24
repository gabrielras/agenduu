class AwardTemplate < ApplicationRecord
  belongs_to :award

  has_enumeration_for :template_type, with: AwardTemplateEnum::TemplateTypes, create_helpers: true

  validates :template_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :text_submit, presence: true
  validates :primary_color, presence: true
  validates :secondary_color, presence: true
end
