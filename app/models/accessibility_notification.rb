class AccessibilityNotification < ApplicationRecord  
  belongs_to :accessibility
  belongs_to :project

  validates :receive_email_when_tagged, presence: true
  validates :receive_email_when_responds, presence: true
end
