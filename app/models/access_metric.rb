class AccessMetric < ApplicationRecord
  belongs_to :organization
  belongs_to :usable, polymorphic: true, optional: true

  validates :data, presence: true
end
