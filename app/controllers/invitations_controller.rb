# frozen_string_literal: true

class User::Common::InvitesController < AbsentUserController
  layout 'common'
  before_action :set_invite

  def show
  end

  def update
    if @invite.present? && @invite.expires_at <= Time.zone.now
      session[:invitation_key] = @invite.key
      redirect_to user_common_invitations_path, notice: 'Confirmado'
    else
      redirect_to user_common_invitations_path, alert: result.error
    end
  end

  private

  def set_invite
    @invite = Invite.find_by_key(params[:id])
  end
end
