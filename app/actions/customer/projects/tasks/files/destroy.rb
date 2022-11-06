# frozen_string_literal: true

module Customer
  module Projects
    module Tasks
      module Files
        class Destroy < Actor
          input :attributes, type: Hash
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
end
