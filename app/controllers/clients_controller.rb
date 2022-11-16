# frozen_string_literal: true

class ClientController < ApplicationController
  before_action :authenticate_client!, :confirm_invite

  private

  def confirm_invite
    if session[:invitation_key].present?
      result = Clients::Invites::Confirm.result(client: current_client, invite_key: session[:invitation_key])

      session[:invitation_key] = nil if result.success?
    end
  end
end
