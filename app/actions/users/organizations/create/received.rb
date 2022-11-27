# frozen_string_literal: true

module Users
  module Organizations
    module Create
      class Received < Actor
        ActiveRecord::Base.transaction do
          play Default, Invites
        end
      end
    end
  end
end
