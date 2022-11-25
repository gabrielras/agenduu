# frozen_string_literal: true

class RewardsController < ApplicationController
  before_action :set_award

  def show; end

  def embedded; end

  private

  def set_award
    @award = policy_scope(Award).find(params[:id])
  end

  def organization
    @organization = Organization.find_by!(slug: request.subdomain)
    raise ActionController::RoutingError.new('Not Found') if @organization.blank?
  end
end
