# frozen_string_literal: true

module Common
  module InvitationLinks
    class Confirm < Actor
      input :user, type: User
      input :invitation_link, type: InvitationLink

      def call
        if Role.where(user: user, role_type: invitation.role_type, organization: organization.role_type).present?
          Role.create!(user: user, role_type: invitation.role_type, organization: organization.role_type)
        end
        if Accessibility.where(project: invitation_link.project, user: user).present?
          Accessibility.create!(project: invitation_link.project, user: user, allows: 'interact')
        end
      end
    end
  end
end
