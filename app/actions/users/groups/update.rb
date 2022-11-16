# frozen_string_literal: true


module Users
  module Groups
    class Update < Actor
      input :attributes, type: Hash
      input :current_user, type: User
      input :group, type: Group

      def call
        ActiveRecord::Base.transaction do
          fail!(error: 'Não possuí autorização') unless user_valid
          self.group.update!(attributes)
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
      
      private

      def user_valid
        ['admin', 'onwer'].include?(current_user.decorate.role.role_type) ||
        Accessibility.where(allows: 'manager', group: group, user: current_user)
      end
    end
  end
end
