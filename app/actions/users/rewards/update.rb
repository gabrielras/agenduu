# frozen_string_literal: true

module Users
  module Rewards
    class Process < Actor
      input :leads_attributes, type: Hash

      output :reward, type: Reward

      def call
        ActiveRecord::Base.transaction do
          Reward.create!(
            affiliate: Affiliate.find_by_key(self.attributes[:code])
            award_history: award_history,
            lead: lead
          )
        end
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def award_history

      end

      def lead

      end
    end
  end
end
