# frozen_string_literal: true

module Users
  module Manager
    module SubTasks
      class Update < Actor
        input :attributes, type: Hash
        input :sub_task, type: SubTask

        def call
          ActiveRecord::Base.transaction do
            self.sub_task.update!(attributes)
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
