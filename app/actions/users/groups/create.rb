# frozen_string_literal: true

module Users
  module Groups
    class Create < Actor
      input :attributes, type: Hash

      output :group, type: Group

      def call
        ActiveRecord::Base.transaction do
          self.group = Group.new(attributes)
          group.save!
  
          Manager::UserAccessibilities::Create.result(
            attributes: { group: group, user: group.creator, allow: 'manager' }
          )
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
