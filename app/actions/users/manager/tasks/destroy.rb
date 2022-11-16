# frozen_string_literal: true

module Users
  module Manager
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
