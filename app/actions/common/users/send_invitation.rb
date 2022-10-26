# frozen_string_literal: true

module Common
  module Users
    class SendInvitation < Actor
      input :user, type: User

      def call
        unless user.invitation
          user.update!(email_security_key: SecureRandom.uuid)

          UserMailer.with(user: user, email_security_key: user.email_security_key).invitation.deliver_later
        end
      end
    end
  end
end
