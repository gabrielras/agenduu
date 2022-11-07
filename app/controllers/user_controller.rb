# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!, :confirm_invitation_by_link, :mandatory_email_authentication

  private

  def mandatory_email_authentication
    if Common::Users::MandatoryEmailAuthorization.result(user: current_user).success? && controller_path.include?('user/common/authorizations')
      redirect_to user_common_authorizations_path
    end
  end

  def confirm_invitation_by_link
    invitation_link = InvitationLink.find_by_key(session[:invitation_key])
    if invitation_link.present? && invitation_link.expires_at <= Time.zone.now
      Common::InvitationLinks::Confirm.result(user: current_user, invitation_link: invitation_link)
    end
  end
end
