# frozen_string_literal: true

module Customer
  module Projects
    module Messages
      class Create < Actor
        input :attributes, type: Hash

        output :message, type: Message

        def call
          ActiveRecord::Base.transaction do
            self.message = Message.new(attributes)
            message.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
