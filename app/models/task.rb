class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :creator, class_name: 'User'
  belongs_to :folder, optional: true
  belongs_to :project, optional: true

  has_one :schedule, as: :taskable
  
  has_many :messages, dependent: :destroy
  has_many :mentions, as: :viewer

  has_enumeration_for :type_task, with: TaskEnum::TypesTasks, create_helpers: true
  
  has_many_attached :files
  has_rich_text :description

  validates :type_task, presence: true
  validates :title, presence: true
end
