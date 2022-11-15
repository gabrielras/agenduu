class PrintAward < ApplicationRecord
  validates :current_client, presence: true
  validates :new_client, presence: true
end
