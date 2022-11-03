# frozen_string_literal: true

module Provider
  module Manager
    module Accessibilities
      class Participate < Actor
        input :current_user, type: User
        input :project, type: Project

        def call
          ActiveRecord::Base.transaction do
            Create.result(
              attributes: { project: project, user: current_user, allows: 'manager' }
            )
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
