# frozen_string_literal: true

module Users
  module Manager
    module Invites
      class Destroy < Actor
        output :invite, type: Invite

        def call
          invite.destroy
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
