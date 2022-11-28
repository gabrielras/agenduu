class Partnership < ApplicationRecord
  belongs_to :organization

  has_many :rewards, dependent: :destroy

  accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validates :subtitle, presence: true
  validates :description, presence: true

  validates :title_form, presence: true
  validates :subtitle_form, presence: true

  validates :rule_title, presence: true
  validates :rule_description, presence: true, if: :rule_title_id
end
