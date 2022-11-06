# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :email_authentication

  private

  def email_authentication
    invitation = Invitation.find_by_key(session[:invitation_key])
    if invitation.present? && invitation.expires_at <= Time.zone.now
      Common::Invitations::Confirm.result(user: current_user, invitation: invitation)
    end

    

  end
end
