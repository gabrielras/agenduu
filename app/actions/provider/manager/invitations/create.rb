# frozen_string_literal: true

module Provider
  module Manager
    module Invitations
      class Create < Actor
        input :attributes, type: Hash

        output :invitation, type: Invitation

        def call
          ActiveRecord::Base.transaction do
            if there_is_no_invitation?
              self.invitation = Invitation.new(attributes.merge(role_type: 'customer', expires_at: expires_at))
              invitation.save!

              Common::Invitations::Send.result(invitation: invitation)
            else
              fail!(error: 'Convite já foi enviado')
            end
          end
        rescue StandardError => e
          fail!(error: e.message)
        end

        private

        def there_is_no_invitation?
          Invitation.where(email: attributes[:email], organization: attributes[:organization], project: attributes[:project]).blank?
        end
      end
    end
  end
end
