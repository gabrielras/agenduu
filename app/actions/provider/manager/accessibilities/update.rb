# frozen_string_literal: true

module Provider
  module Manager
    module Accessibilities
      class Update < Actor
        input :attributes, type: Hash
        input :accessibility, type: Accessibility

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
