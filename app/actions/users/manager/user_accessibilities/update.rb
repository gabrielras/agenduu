# frozen_string_literal: true

module Users
  module Manager
    module UserAccessibilities
      class Update < Actor
        input :attributes, type: Hash
        input :accessibility, type: UserAccessibility

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
