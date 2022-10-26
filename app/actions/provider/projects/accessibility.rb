# frozen_string_literal: true

module Provider
  module Projects
    class Accessibility < Actor
      input :project, type: Project

      input :accessibilities, type: Enumerable

      def call
        self.project = Project.new(attributes)
        project.save!
        ::Accessibility.result(project: project)
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
