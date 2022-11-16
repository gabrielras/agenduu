# frozen_string_literal: true

module Users
  module Manager
    module SubTasks
      class Create < Actor
        input :attributes, type: Hash

        output :sub_task, type: SubTask

        def call
          ActiveRecord::Base.transaction do
            self.sub_task = SubTask.new(attributes)
            sub_task.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
