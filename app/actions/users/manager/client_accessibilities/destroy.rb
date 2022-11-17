# frozen_string_literal: true

module Users
  module Manager
    module ClientAccessibilities
      class Destroy < Actor
        input :accessibility, type: ClientAccessibility

        def call
          ActiveRecord::Base.transaction do
            accessibility.destroy
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
