# frozen_string_literal: true

module Provider
  module InvitationLinks
    class Destroy < Actor
      output :invitation_link, type: InvitationLink

      def call
        self.invitation_link.destroy
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
