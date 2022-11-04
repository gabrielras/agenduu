# frozen_string_literal: true

module Common
  module Invitations
    class Rejected < Actor
      input :user, type: User
      input :invitation, type: Invitation

      def call
        fail!(error: 'Não é possível realizar essa ação') if user.email != invitation.email

        invitation.update!(state: 'rejected')
      end
    end
  end
end
