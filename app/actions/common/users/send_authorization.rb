# frozen_string_literal: true

module Common
  module Users
    class SendAuthorization < Actor
      input :user, type: User

      def call
        if !user.confirm_email || (user.expire_invitation.present? && user.expire_invitation <= Time.zone.now)
          user.update!(email_security_key: SecureRandom.uuid, expire_invitation: (Time.zone.now + 2.minutes))

          UserMailer.with(user: user, email_security_key: user.email_security_key).invitation.deliver_later
        end
      end
    end
  end
end
