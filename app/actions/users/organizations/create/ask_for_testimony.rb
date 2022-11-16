# frozen_string_literal: true

module User
  module Organizations
    module Create
      class AskForTestimonies < Actor 
        input :organization, type: Organization

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
