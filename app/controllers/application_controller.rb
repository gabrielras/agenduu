class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  before_action :invite

  def invite
    session[:invite_key] = params[:invite]
  end
end
