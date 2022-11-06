# frozen_string_literal: true

module Customer
  module Projects
    module Tasks
      class Destroy < Actor
        input :task, type: Task

        def call
          self.task.destroy
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
