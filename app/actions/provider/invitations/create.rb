# frozen_string_literal: true

module Provider
  module Invitations
    class Create < Actor
      input :attributes, type: Hash
      input :current_user, type: User

      output :invitation, type: Invitation

      def call
        ActiveRecord::Base.transaction do
          if Invitation.where(email: attributes[:email], organization: current_user.decorate.provider).blank?
            self.invitation = Invitation.new(attributes.merge(role_type: role_type, expires_at: expires_at, state: 'pending'))
            invitation.save!

            mandatory_role
            invalid_organization

            Common::Invitations::Send.result(invitation: invitation)
          else
            fail!(error: 'Convite já foi enviado')
          end
        end
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def role_type
        if current_user.decorate.role.role_type == 'owner' && ['admin', 'employee', 'customer'].include?(attributes[:role_type])
          attributes[:role_type]
        elsif current_user.decorate.role.role_type == 'admin' && ['admin', 'employee', 'customer'].include?(attributes[:role_type])
          attributes[:role_type]
        elsif current_user.decorate.role.role_type == 'employee' && ['customer'].include?(attributes[:role_type])
          attributes[:role_type]
        else
          fail!(error: 'Função não permitida pelo cargo')
        end
      end

      def mandatory_role
        fail!(error: 'É necessário ter um cargo') if current_user.decorate.provider.blank?
      end

      def invalid_organization
        fail!(error: 'Organização diferente da sua') if current_user.decorate.provider == invitation.organization
      end

      def expires_at
        Time.zone.now + 3.days
      end
    end
  end
end
