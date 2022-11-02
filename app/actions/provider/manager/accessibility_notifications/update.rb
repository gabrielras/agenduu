# frozen_string_literal: true

module Provider
  module Manager
    module Accessibilities
      class Update < Actor
        input :attributes, type: Hash
        input :accessibility_notification, type: AccessibilityNotification
        input :current_user, type: User

        def call
          ActiveRecord::Base.transaction do
            validate_user

            self.accessibility_notification.update!(attributes)
          end
        rescue StandardError => e
          fail!(error: e.message)
        end

        private

        def validate_user
          return if current_user == accessibility_notification.accessibility.user
          
          fail!(error: 'Não é possível editar')
        end
      end
    end
  end
end
