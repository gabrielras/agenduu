# frozen_string_literal: true

module Common
  module Users
    class MandatoryEmailAuthorization < Actor
      input :user, type: User

      def call
        fail!(error: 'é preciso confirmar seu email') if self.user.confirm_email == false && Invitation.where(state: 'pending', user: self.user).present?
      end
    end
  end
end
