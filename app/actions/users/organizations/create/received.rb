# frozen_string_literal: true

module Users
  module Organizations
    module Create
      class Received < Actor
        play Default, Invites, Partnerships, Rewards

        def rollback
          organization.destroy
        end
      end
    end
  end
end
