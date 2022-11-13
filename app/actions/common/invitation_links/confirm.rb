# frozen_string_literal: true

module Common
  module InviteLinks
    class Confirm < Actor
      input :user, type: User
      input :invite_link, type: InviteLink

      def call
        if Role.where(user: user, role_type: invitation.role_type, organization: organization.role_type).present?
          Role.create!(user: user, role_type: invitation.role_type, organization: organization.role_type)
        end
        if Accessibility.where(project: invite_link.project, user: user).present?
          Accessibility.create!(project: invite_link.project, user: user, allows: 'interact')
        end
      end
    end
  end
end
