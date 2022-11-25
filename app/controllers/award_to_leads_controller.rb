# frozen_string_literal: true

class AwardsController < ApplicationController
  before_action :set_reward
  
  def show; end

  private

  def set_reward
    @reward = policy_scope(Reward).find(params[:id])
  end

  def organization
    @organization = Organization.find_by!(slug: request.subdomain)
    raise ActionController::RoutingError.new('Not Found') if @organization.blank?
  end
end
