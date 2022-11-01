# frozen_string_literal: true

module Provider
  module Manager
    module Accessibilities
      class Destroy < Actor
        input :accessibility, type: Accessibility

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
