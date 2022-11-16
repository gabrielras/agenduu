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

            upload_files
          end
        rescue StandardError => e
          fail!(error: e.message)
        end

        private

        def upload_files
          return if attributes[:files].blank?
          

          task.files.attach(attributes[:files])
        end
      end
    end
  end
end
