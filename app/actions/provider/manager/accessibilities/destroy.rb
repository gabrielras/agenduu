# frozen_string_literal: true

module Provider
  module Manager
    module Accessibilities
      class Destroy < Actor
        input :accessibility, type: Accessibility

        def call
          ActiveRecord::Base.transaction do
            validation_by_role_type
            accessibility.destroy
          end
        rescue StandardError => e
          fail!(error: e.message)
        end

        private

        def validation_by_role_type
          user = accessibility.user

          fail!(error: 'Não é possível criar acessibilidade para esse usuário') unless user.decorate.role.employee? || user.decorate.role.customer?
        end
      end
    end
  end
end
