# frozen_string_literal: true

class AwardsController < ApplicationController
  before_action :set_award
  
  def show; end

  private

  def set_reward
    @reward = policy_scope(Award).find(params[:id])
  end

  def organization
    @organization = Organization.find_by!(slug: request.subdomain)
    raise ActionController::RoutingError.new('Not Found') if @organization.blank?
  end
end
