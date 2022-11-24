class AwardAffiliate < ApplicationRecord
  belongs_to :award
  belongs_to :affiliate
end
