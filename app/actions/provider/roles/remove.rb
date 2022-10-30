# frozen_string_literal: true

module Provider
  module Roles
    class Remove < Actor
      input :current_user, type: User
      input :user, type: User

      def call
        ActiveRecord::Base.transaction do
          invalid_organization
          mandatory_role
          role_type_validator

          user.role.destroy
        end
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def role_type_validator
        if current_user.decorate.role.owner? && ['owner'].exclude?(user.role.role_type)
        elsif current_user.decorate.role.admin? && ['customer', 'employee'].include?(user.role.role_type)
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
