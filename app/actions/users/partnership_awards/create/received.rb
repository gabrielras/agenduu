# frozen_string_literal: true

module Users
  module PartnershipAwards
    module Create
      class Received < Actor
        ActiveRecord::Base.transaction do
          play Default, Templates
        end
      end
    end
  end
end
