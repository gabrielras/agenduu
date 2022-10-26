# frozen_string_literal: true

module Provider
  module Roles
    class Create < Actor
      input :attributes, type: User

      output :user, type: User

      def call
        ActiveRecord::Base.transaction do
          if User.find_by_email(attributes[:email]).blank?
            self.user = User.new(attributes.merge(password: SecureRandom.uuid))

            validate_owner
            validate_customer

            user.save!
            mandatory_role

            ::Common::Users::SendInvitation.result(user: user)
          else
            self.user = User.find_by_email(attributes[:email])

            validate_owner
            validate_customer

            Role.create!(
              user: user, role_type: attributes[:roles][:role_type], organization_id: attributes[:roles][:organization_id]
            )
            ::Common::Users::SendInvitation.result(user: user) unless user.invitation
          end
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
      
      private

      def validate_owner
        fail!(error: 'Só é possível ter um proprietário') if Role.where(company: company, role_type: 'owner').present?
      end

      def validate_customer
        fail!(error: 'Não é possível adicionar um cliente') if attributes[:roles][:role_type] == 'customer'
      end

      def mandatory_role
        fail!(error: 'É necessário ter um cargo') if user.decorate.provider.blank?
      end
    end
  end
end
