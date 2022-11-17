# frozen_string_literal: true

module Users
  module Manager
    module Tasks
      class Create < Actor
        input :attributes, type: Hash

        output :task, type: Task

        def call
          ActiveRecord::Base.transaction do
            self.task = Task.new(attributes.except(:files))
            task.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
