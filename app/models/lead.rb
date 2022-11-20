class Lead < ApplicationRecord
  belongs_to :organization
  belongs_to :origin, polymorphic: true

  validates :full_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true

  validates :email, uniqueness: { scope: :organization_id }
  validates :phone_number, uniqueness: { scope: :organization_id }
end
