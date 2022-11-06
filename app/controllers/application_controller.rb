class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  def invitation_by_link
    session[:invitation_key] = params[:invitation]
  end
end
