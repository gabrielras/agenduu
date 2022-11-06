# frozen_string_literal: true

module Customer
  module Projects
    module Messages
      class Destroy < Actor
        input :message, type: Message

        def call
          self.message.destroy
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
