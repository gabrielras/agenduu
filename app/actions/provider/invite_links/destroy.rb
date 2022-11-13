# frozen_string_literal: true

module Provider
  module InviteLinks
    class Destroy < Actor
      output :invite_link, type: InviteLink

      def call
        self.invite_link.destroy
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
