# frozen_string_literal: true


module Provider
  module Projects
    class Update < Actor
      input :attributes, type: Hash
      input :current_user, type: User
      input :project, type: Project

      def call
        ActiveRecord::Base.transaction do
          fail!(error: 'Não possuí autorização') unless user_valid
          self.project.update!(attributes)
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
      
      private

      def user_valid
        ['admin', 'onwer'].include?(current_user.decorate.role.role_type) ||
        Accessibility.where(allows: 'manager', foldable: project, user: current_user)
      end
    end
  end
end
