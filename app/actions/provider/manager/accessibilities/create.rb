# frozen_string_literal: true

module Provider
  module Manager
    module Accessibilities
      class Create < Actor
        input :attributes, type: Hash

        output :accessibility, type: Accessibility

        def call
          ActiveRecord::Base.transaction do
            validation_by_role_type

            self.accessibility = Accessibility.new(attributes)
            accessibility.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end

        private

        def validation_by_role_type
          fail!(error: 'Não é possível criar acessibilidade para esse usuário') unless attributes[:user].decorate.role.employee? || attributes[:user].decorate.role.customer?
        end
      end
    end
  end
end
