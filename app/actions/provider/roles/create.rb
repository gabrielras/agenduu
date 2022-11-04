# frozen_string_literal: true

module Provider
  module Roles
    class Create < Actor
      input :attributes, type: Hash
      input :current_user, type: User

      output :user, type: User

      def call
        ActiveRecord::Base.transaction do
          if Invitation.find_by_email(attributes[:email]).blank?
            self.invitation = Invitation.new(
              attributes.merge(role_type: role_type, key: SecureRandom.uuid, expires_at: expires_at)
            )
            invitation.save!

            mandatory_role
            invalid_organization
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
        if attributes[:project].present?
          Time.zone.now + 1.day
        else
          Time.zone.now + 3.days
        end
      end
    end
  end
end
