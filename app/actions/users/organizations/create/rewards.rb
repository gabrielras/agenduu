# frozen_string_literal: true

module Users
  module Organizations
    module Create
      class Rewards < Actor 
        input :organization, type: Organization

        def call
          Reward.create!(
            organization_id: organization.id,
            type_of_reward: 'main',
            to_affiliate: 'Ganhe 20 R$ por indicação 👋',
            to_lead: 'Receba 10% de Desconto',
            social_network: 'whatsapp',
            username: organization.phone_number
          )
        end
      end
    end
  end
end
