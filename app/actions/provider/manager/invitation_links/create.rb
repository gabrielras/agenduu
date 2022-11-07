# frozen_string_literal: true

module Provider
  module Manager
    module InvitationLinks
      class Create < Actor
        input :project, type: Project

        output :invitation_link, type: InvitationLink

        def call
          ActiveRecord::Base.transaction do
            self.invitation_link = InvitationLink.new(attributes)

            existing_link = InvitationLink.where(project: attributes[:project] , organization: attributes[:organization], role_type: attributes[:role_type]).take
            existing_link.destroy if existing_link.present?

            invitation_link.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
