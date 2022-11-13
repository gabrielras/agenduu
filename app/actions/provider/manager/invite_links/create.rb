# frozen_string_literal: true

module Provider
  module Manager
    module InviteLinks
      class Create < Actor
        input :project, type: Project

        output :invite_link, type: InviteLink

        def call
          ActiveRecord::Base.transaction do
            self.invite_link = InviteLink.new(attributes)

            existing_link = InviteLink.where(project: attributes[:project] , organization: attributes[:organization], role_type: attributes[:role_type]).take
            existing_link.destroy if existing_link.present?

            invite_link.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end