# frozen_string_literal: true

class OrganizationDecorator < ApplicationDecorator
  def reward_main
    organization.rewards.find_by(type_of_reward: 'main')
  end
end
