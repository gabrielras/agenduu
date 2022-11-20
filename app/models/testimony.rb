class Testimony < ApplicationRecord
  belongs_to :organization
  belongs_to :client, optional: true
  belongs_to :group, optional: true

  has_one :lead, as: :origin

  has_one_attached :video
end
