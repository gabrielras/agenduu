# frozen_string_literal: true

module Provider
  module Invitations
    class Destroy < Actor
      output :invitation, type: Invitation

      def call
        self.invitation.destroy
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
