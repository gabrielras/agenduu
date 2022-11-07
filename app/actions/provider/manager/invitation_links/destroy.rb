# frozen_string_literal: true

module Provider
  module Manager
    module InvitationLinks
      class Destroy < Actor
        output :invitation_link, type: InvitationLink

        def call
          invitation_link.destroy
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
