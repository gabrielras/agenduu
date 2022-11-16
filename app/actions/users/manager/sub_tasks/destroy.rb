# frozen_string_literal: true

module Users
  module Manager
    module SubTasks
      class Destroy < Actor
        input :sub_task, type: SubTask

        def call
          self.task.destroy
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
