class InteractionLog < ApplicationRecord
  belongs_to :organization
  belongs_to :usable, polymorphic: true, optional: true

  validates :situation, presence: true
end
