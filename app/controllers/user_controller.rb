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
    invite_link = ::InviteLink.find_by_key(session[:invitation_key])
    if invite_link.present? && invite_link.expires_at <= Time.zone.now
      Common::InviteLinks::Confirm.result(user: current_user, invite_link: invite_link)
    end
  end
end
