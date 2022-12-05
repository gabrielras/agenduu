# frozen_string_literal: true

module Users
  module AffiliateCampaigns
    class Update < Actor
      input :attributes, type: Hash
      input :affiliate_campaign, type: AffiliateCampaign

      def call
        ActiveRecord::Base.transaction do
          self.affiliate_campaign.update!(attributes)

          affiliate_campaign.organization.decorate.reward_main.update!(reward_params)
        end
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def affiliate_campaign_params
        attributes.execept(:rewards_attributes)
      end

      def reward_params
        attributes[:rewards_attributes]
      end
    end
  end
end
