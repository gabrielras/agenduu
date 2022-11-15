class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :creator, class_name: 'User'
  belongs_to :group, optional: true
  
  has_many :mentions, as: :viewer, dependent: :destroy
  has_many :sub_tasks, dependent: :destroy

  accepts_nested_attributes_for :sub_tasks, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :mentions, reject_if: :all_blank, allow_destroy: true
  
  validates :type_task, presence: true
  validates :title, presence: true
  validates :send_email, inclusion: { in: [ true, false ] }
end
