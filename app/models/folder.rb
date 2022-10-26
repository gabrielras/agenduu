class Folder < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :project
  has_and_belongs_to_many :foldables, class_name: 'Folder'

  has_many :users, :through => :accessibilities

  validates :title, presence: true
end
