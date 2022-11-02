class AccessibilityNotification < ApplicationRecord  
  belongs_to :accessibility

  validates :receive_email_when_tagged, inclusion: { in: [ true, false ] }
  validates :receive_email_when_responds, inclusion: { in: [ true, false ] }
end
