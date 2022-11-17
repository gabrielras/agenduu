# frozen_string_literal: true

module Users
  module Manager
    module ClientAccessibilities
      class Create < Actor
        input :attributes, type: Hash

        output :accessibility, type: ClientAccessibility

        def call
          ActiveRecord::Base.transaction do
            self.accessibility = UserAccessibility.new(attributes)
            accessibility.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
