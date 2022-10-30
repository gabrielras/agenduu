# frozen_string_literal: true

module Provider
  module Manager
    module Accessibilities
      class Update < Actor
        input :attributes, type: Hash
        input :accessibility, type: Accessibility

        def call
          ActiveRecord::Base.transaction do
            validation_by_role_type

            self.folder.update!(attributes)
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end

      private

      def validation_by_role_type
        user = User.find(attributes[:user_id])
        fail!(error: 'Não é possível criar acessibilidade para esse usuário') unless user.decorate.role.employee? || user.decorate.role.customer?
      end
    end
  end
end
