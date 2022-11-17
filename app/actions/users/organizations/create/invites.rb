# frozen_string_literal: true

module User
  module Organizations
    module Create
      class Invites < Actor 
        input :organization, type: Organization

        def call
          ActiveRecord::Base.transaction do
            Invite.create!(
              organization: organization,
              expires_at: Time.zone.now + 3.days,
              role_type: 'admin'
            )
            Invite.create!(
              organization: organization,
              expires_at: Time.zone.now + 3.days,
              role_type: 'employee'
            )
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
