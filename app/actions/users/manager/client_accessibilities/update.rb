# frozen_string_literal: true

module Users
  module Manager
    module ClientAccessibilities
      class Update < Actor
        input :attributes, type: Hash
        input :accessibility, type: ClientAccessibility

        def call
          ActiveRecord::Base.transaction do
            self.accessibility.update!(attributes)
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
