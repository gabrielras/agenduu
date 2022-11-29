# frozen_string_literal: true

module Users
  module Rewards
    module Affiliates
      class Create < Actor
        input :attributes, type: Hash

        output :reward, type: Reward

        def call
          ActiveRecord::Base.transaction do
            self.reward = Reward.create!(
              
            )
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
