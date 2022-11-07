# frozen_string_literal: true

module Common
  module Invitations
    class Confirm < Actor
      input :user, type: User
      input :invitation, type: Invitation

      def call
        return if invitation.accepted?

        fail!(error: 'Não é possível realizar essa ação') if user.email != invitation.email
        fail!(error: 'O convite expirou') if invitation.expires_at <= Time.zone.now

        invitation.update!(state: 'accepted')
        
        if Role.where(user: user, role_type: invitation.role_type, organization: invitation.organization).present?
          Role.create!(user: user, role_type: invitation.role_type, organization: invitation.organization)
        end

        if Accessibility.where(project: invitation.project, user: user).present?
          Accessibility.create!(project: invitation.project, user: user, allows: 'interact')
        end
      end
    end
  end
end
