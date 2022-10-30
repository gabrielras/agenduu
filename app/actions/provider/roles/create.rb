# frozen_string_literal: true

module Provider
  module Roles
    class Create < Actor
      input :attributes, type: Hash
      input :current_user, type: User

      output :user, type: User

      def call
        ActiveRecord::Base.transaction do
          if User.find_by_email(attributes[:email]).blank?
            self.user = User.new(
              full_name: attributes[:full_name], email: attributes[:email], password: SecureRandom.uuid
            )
            user.save!
            Role.create!(
              user: user, role_type: role_type(attributes[:role][:role_type]), organization: current_user.decorate.provider
            )
            mandatory_role
            invalid_organization

            ::Common::Users::SendInvitation.result(user: user)
          else
            self.user = User.find_by_email(attributes[:email])

            Role.create!(
              user: user,
              role_type: role_type(attributes[:role][:role_type]),
              organization: current_user.decorate.provider
            )
            ::Common::Users::SendInvitation.result(user: user) unless user.invitation
          end
        end
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def role_type(role_type_attributes)
        if current_user.decorate.role.role_type == 'owner' && ['admin', 'employee', 'customer'].include?(role_type_attributes)
          role_type_attributes
        elsif current_user.decorate.role.role_type == 'admin' && ['admin', 'employee', 'customer'].include?(role_type_attributes)
          role_type_attributes
        elsif current_user.decorate.role.role_type == 'employee' && ['customer'].include?(role_type_attributes)
          role_type_attributes
        else
          fail!(error: 'Função não permitida pelo cargo')
        end
      end

      def mandatory_role
        fail!(error: 'É necessário ter um cargo') if current_user.decorate.provider.blank?
      end

      def invalid_organization
        fail!(error: 'Organização diferente da sua') if current_user.decorate.provider == user.decorate.provider
      end
    end
  end
end
