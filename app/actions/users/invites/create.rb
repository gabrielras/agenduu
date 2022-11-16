# frozen_string_literal: true

module Users
  module Invites
    class Create < Actor
      input :attributes, type: Hash

      output :invite, type: Invite

      def call
        ActiveRecord::Base.transaction do
          self.invite = Invite.new(attributes)

          existing_link = Invite.where(organization: attributes[:organization], role_type: attributes[:role_type]).take
          existing_link.destroy if existing_link.present?

          invite.save!
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
