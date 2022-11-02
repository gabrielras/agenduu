class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :creator, class_name: 'User'
  belongs_to :folder, optional: true
  belongs_to :project, optional: true

  has_one :schedule, as: :taskable
  
  has_many :messages, dependent: :destroy
  has_many :mentions, as: :viewer, dependent: :destroy
  has_many :task_files, dependent: :destroy

  accepts_nested_attributes_for :task_files, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :mentions, reject_if: :all_blank, allow_destroy: true

  has_enumeration_for :type_task, with: TaskEnum::TypesTasks, create_helpers: true
  
  has_rich_text :description

  validates :type_task, presence: true
  validates :title, presence: true
  validates :send_email, inclusion: { in: [ true, false ] }
end
