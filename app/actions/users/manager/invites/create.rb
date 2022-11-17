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

            existing_invite = Invite.where(group: attributes[:group], role_type: attributes[:role_type]).take
            existing_invite.destroy if existing_invite.present?

            invite.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
