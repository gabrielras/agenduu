# frozen_string_literal: true

module RewardEnum
  class SocialNetworks < EnumerateIt::Base
    associate_values(:facebook, :instagram, :telegram, :whatsapp)
  end
end
