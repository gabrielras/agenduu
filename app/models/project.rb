class Project < ApplicationRecord
  belongs_to :organization

  has_many :accessibilities, as: :foldable
  has_many :folders, dependent: :destroy
  has_many :project_notifications, dependent: :destroy
  has_many :users, :through => :accessibilities

  accepts_nested_attributes_for :project_notifications, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
end
