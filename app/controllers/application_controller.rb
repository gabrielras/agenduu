class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  before_action :invite, :set_organization

  def invite
    session[:invite_key] = params[:invite]
  end

  def set_organization
    return if request.subdomain.blank?
    @organization = Organization.find_by!(slug: request.subdomain)
  end
end
