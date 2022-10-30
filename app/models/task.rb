class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  belongs_to :folder, optional: true

  has_one :schedule, as: :taskable
  
  has_many :messages, dependent: :destroy
  has_many :mentions, dependent: :destroy

  has_enumeration_for :types_task, with: TaskEnum::TypesTask, create_helpers: true
  
  has_many_attached :files
  has_rich_text :description

  validates :types_task, presence: true
  validates :title, presence: true
end
