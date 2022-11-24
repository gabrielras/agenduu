class Lead < ApplicationRecord
  belongs_to :organization

  validates :full_name, presence: true

  validates :email, uniqueness: { scope: :organization_id }
  validates :phone_number, uniqueness: { scope: :organization_id }
end
