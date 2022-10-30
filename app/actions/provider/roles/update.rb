# frozen_string_literal: true

module Provider
  module Roles
    class Update < Actor
      input :attributes, type: User
      input :current_user, type: User
      input :user, type: User

      def call
        ActiveRecord::Base.transaction do
          invalid_organization
          mandatory_role

          role_type_validator

          user.update!(role_type: role_type)
        end
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def role_type_validator
        if current_user.decorate.role.owner? && ['admin', 'employee'].include?(attributes[:role_type])
        elsif current_user.decorate.role.admin? && ['admin', 'owner'].exclude?(user.role.role_type) && ['admin', 'employee'].include?(attributes[:role_type])
        else
          fail!(error: 'Função não permitida pelo cargo')
        end
      end

      def mandatory_role
        fail!(error: 'É necessário ter um cargo') if user.decorate.provider.blank?
      end

      def invalid_organization
        fail!(error: 'Organização diferente da sua') if current_user.decorate.provider == user.decorate.provider
      end
    end
  end
end
