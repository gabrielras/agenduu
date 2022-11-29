# frozen_string_literal: true

module Users
  module Rewards
    module Affiliates
      class Destroy < Actor
        input :reward, type: Reward

        def call
          validate_reward

          reward.destroy
        rescue StandardError => e
          fail!(error: e.message)
        end

        private

        def validate_reward

        end
      end
    end
  end
end
