# frozen_string_literal: true

module Provider
  module Roles
    class Update < Actor
      input :attributes, type: User
      input :user, type: User

      def call
        ActiveRecord::Base.transaction do
          validate_role_type

          user.update!(role_type: attributes[:role_type], blocked: attributes[:blocked])
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
      
      private

      def validate_role_type
        fail!(error: 'Cargo indisponível') unless ['admin', 'manager', 'employee'].include?(attributes[:role_type])
        fail!(error: 'Não é possível atualizar esse usuário') if ['customer', 'owner'].include?(user.role.role_type)
      end
    end
  end
end
