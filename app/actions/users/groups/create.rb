# frozen_string_literal: true

module Users
  module Groups
    class Create < Actor
      input :attributes, type: Hash
      input :current_user, type: User

      output :group, type: Group

      def call
        ActiveRecord::Base.transaction do
          self.group = Group.new(attributes.merge(creator: current_user))
          group.save!
  
          Manager::Accessibilities::Employees::Create.result(
            attributes: { group: group, user: current_user, allow: 'manager' }
          )
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
