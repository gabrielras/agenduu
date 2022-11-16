# frozen_string_literal: true

module Users
  module Invites
    class Confirm < Actor
      input :user, type: User
      input :invite, type: Invite

      def call
        if Role.where(user: user, role_type: invite.role_type, organization: organization.role_type).present?
          Role.create!(user: user, role_type: invite.role_type, organization: organization.role_type)
        end
        if Accessibility.where(group: invite.group, user: user).present?
          Accessibility.create!(group: invite.group, user: user, allow: 'interact')
        end
      end
    end
  end
end
