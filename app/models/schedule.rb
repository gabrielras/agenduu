class Schedule < ApplicationRecord
  belongs_to :taskable, polymorphic: true

  validates :execution_date, presence: true
  validates :days_to_make_mandatory, presence: true
  validates :repeat, inclusion: { in: [ true, false ] }

  validates :interval_repeat, numericality: { in: [0..23] }, :allow_nil => true
  validates :day_of_repeat, numericality: { in: [0..23] }, :allow_nil => true
  validates :hour_of_repeat, numericality: { in: [0, 15, 30, 45] }, :allow_nil => true
  validates :minute_of_repeat, numericality: { in: [0, 15, 30, 45] }, :allow_nil => true
end
