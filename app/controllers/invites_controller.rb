# frozen_string_literal: true

class Common::InvitesController < CommonController
  before_action :set_invite

  def show; end

  private

  def set_invite
    @invite = Invite.find_by_key(params[:id])
  end
end
