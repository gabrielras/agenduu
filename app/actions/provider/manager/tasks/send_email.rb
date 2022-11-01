# frozen_string_literal: true

module Provider
  module Manager
    module Tasks
      class SendEmail < Actor
        input :task, type: Task

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
