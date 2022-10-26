# frozen_string_literal: true

module Common
  module Users
    class AuthorizeInvitation < Actor
      input :email_security_key, type: String
      input :password, type: String

      output :user, type: User

      def call
        self.user = User.find_by_email_security_key(email_security_key)
        user.update!(invitation: true, password: password)
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
