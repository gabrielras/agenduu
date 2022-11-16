# frozen_string_literal: true

module Users
  module Manager
    module Invites
      class Create < Actor
        input :attributes, type: Hash
        input :group, type: Group

        output :invite, type: Invite

        def call
          ActiveRecord::Base.transaction do
            self.invite = Invite.new(attributes)

            existing_link = Invite.where(group: attributes[:group], role_type: attributes[:role_type]).take
            existing_link.destroy if existing_link.present?

            invite.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
