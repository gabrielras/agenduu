class AffiliateLead < ApplicationRecord
  belongs_to :affiliate
  belongs_to :lead
end
