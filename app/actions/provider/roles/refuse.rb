# frozen_string_literal: true

module Provider
  module Roles
    class Refuse < Actor
      input :organization_id, type: String
      input :user, type: User

      def call
        ActiveRecord::Base.transaction do
          fail!(error: 'Não é possível recusar como proprietário') if role.owner?

          role.destroy
        end
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def role
        Organization.find(organization_id).roles.where(user: user).take
      end
    end
  end
end
