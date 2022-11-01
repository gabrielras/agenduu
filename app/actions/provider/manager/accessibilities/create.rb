# frozen_string_literal: true

module Provider
  module Manager
    module Accessibilities
      class Create < Actor
        input :attributes, type: Hash

        output :accessibility, type: Accessibility

        def call
          ActiveRecord::Base.transaction do
            self.accessibility = Accessibility.new(attributes)
            accessibility.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
