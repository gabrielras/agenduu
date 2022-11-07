class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  before_action :invitation_by_link, :email_security_key

  def invitation_by_link
    session[:invitation_key] = params[:invitation]
  end

  def email_security_key
    session[:email_security_key] = params[:email_security_key]
  end
end
