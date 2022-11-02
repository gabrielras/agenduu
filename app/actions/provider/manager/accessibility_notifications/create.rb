# frozen_string_literal: true

module Provider
  module Manager
    module Accessibilities
      class Create < Actor
        input :attributes, type: Hash

        output :accessibility_notification, type: AccessibilityNotification

        def call
          ActiveRecord::Base.transaction do
            self.accessibility_notification = AccessibilityNotification.new(attributes)
            accessibility_notification.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
