class ProjectNotification < ApplicationRecord  
  belongs_to :project
  belongs_to :user

  validates :receive_email_when_tagged, presence: true
  validates :receive_email_when_client_responds, presence: true
end
