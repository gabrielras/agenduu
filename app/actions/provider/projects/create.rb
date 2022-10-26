# frozen_string_literal: true

module Provider
  module Projects
    class Create < Actor
      input :attributes, type: Hash

      output :project, type: Project

      def call
        self.project = Project.new(attributes.except(:user_ids))
        project.save!

        ::Accessibility.result(project: project, user_ids: attributes)
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def validate_providers

      end
    end
  end
end
