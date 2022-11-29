# frozen_string_literal: true

module Users
  module Partnerships
    class Update < Actor
      input :attributes, type: Hash
      input :partnership, type: Partnership

      def call
        ActiveRecord::Base.transaction do
          self.partnership.update!(attributes)

          partnership.organization.decorate.reward_main.update!(reward_params)
        end
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def partnership_params
        attributes.execept(:rewards_attributes)
      end

      def reward_params
        attributes[:rewards_attributes]
      end
    end
  end
end
