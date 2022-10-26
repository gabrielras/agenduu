# frozen_string_literal: true


module Provider
  module Projects
    class Update < Actor
      input :attributes, type: Hash
      input :project, type: Project

      def call
        self.project.update!(attributes)
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
