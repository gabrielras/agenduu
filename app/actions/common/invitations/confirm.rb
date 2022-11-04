# frozen_string_literal: true

module Common
  module Invitations
    class Confirm < Actor
      input :user, type: User
      input :invitation, type: Invitation

      def call
        fail!(error: 'Não é possível realizar essa ação') if user.email != invitation.email
        fail!(error: 'O convite expirou') if invitation.expires_at <= Time.zone.now

        invitation.update!(state: 'accepted')
        Role.create!(
          user: user, role_type: invitation.role_type, organization: organization.role_type
        )

        if invitation.project.present?
          Accessibility.create!(project: invitation.project, user: invitate.user, allows: 'interact')
        end
      end
    end
  end
end
