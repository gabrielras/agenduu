# frozen_string_literal: true

module Provider
  module Manager
    module Tasks
      module Files
        class Add < Actor
          input :attributes, type: Hash

          output :task, type: Task

          def call
            ActiveRecord::Base.transaction do
              self.task = Task.new(attributes)
              task.save!

              upload_files
            end
          rescue StandardError => e
            fail!(error: e.message)
          end

          private

          def upload_files
            return if attributes[:files].blank?
            if task.files.attached?
              task.files.each do |doc|
                doc.purge
              end
            end

            task.files.attach(attributes[:files])
          end
        end
      end
    end
  end
end
