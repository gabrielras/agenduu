# frozen_string_literal: true

module Users
  module AskForTestimonies
    class Create < Actor
      input :attributes, type: Hash

      output :ask_for_testimony, type: AskForTestimony

      def call
        ActiveRecord::Base.transaction do
          self.ask_for_testimony = AskForTestimony.new(attributes)
          ask_for_testimony.save!
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
