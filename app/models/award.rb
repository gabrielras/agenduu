class Award < ApplicationRecord
  belongs_to :organization

  validates :current_client, presence: true
  validates :business_cell_phone, presence: true
  validates :new_client, presence: true
end
