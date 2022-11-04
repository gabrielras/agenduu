# frozen_string_literal: true

module Common
  module Invitations
    class Send < Actor
      input :invitation, type: Invitation

      def call
        if invitation.project.nil?
          UserMailer.with(organization: invitation.organization, email: invitation.email).organization.deliver_later
        else
          UserMailer.with(project: invitation.project, email: invitation.email).project.deliver_later          
        end
      end
    end
  end
end
