# frozen_string_literal: true

module Provider
  module Manager
    module Messages
      class SendEmail < Actor
        input :message, type: Message

        def call
          ActiveRecord::Base.transaction do
            
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
