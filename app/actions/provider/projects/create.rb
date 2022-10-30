# frozen_string_literal: true

module Provider
  module Projects
    class Create < Actor
      input :attributes, type: Hash
      input :current_user, type: User

      output :project, type: Project

      def call
        ActiveRecord::Base.transaction do
          self.project = Project.new(attributes)
          project.save!
  
          Manager::Accessibilities::Create.result(
            attributes: { project: project, user: current_user }
          )
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
