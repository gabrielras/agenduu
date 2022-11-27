# frozen_string_literal: true

module Users
  module Organizations
    module Create
      class Invites < Actor 
        input :organization, type: Organization

        def call
          Invite.create!(
            organization_id: organization.id,
            expires_at: Time.zone.now + 3.days,
            role_type: 'admin'
          )
          Invite.create!(
            organization_id: organization.id,
            expires_at: Time.zone.now + 3.days,
            role_type: 'employee'
          )
        end
      end
    end
  end
end
