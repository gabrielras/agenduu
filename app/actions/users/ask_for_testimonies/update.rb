# frozen_string_literal: true

module Users
  module AskForTestimonies
    class Update < Actor
      input :attributes, type: Hash
      input :ask_for_testimony, type: AskForTestimony

      def call
        ActiveRecord::Base.transaction do
          self.ask_for_testimony.update!(attributes)
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
