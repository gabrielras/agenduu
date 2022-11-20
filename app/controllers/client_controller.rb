# frozen_string_literal: true

class ClientController < ApplicationController
  layout 'client'
  before_action :authenticate_client!, :confirm_invite, :set_organization

  private

  def confirm_invite
    if session[:invitation_key].present?
      result = Clients::Invites::Confirm.result(client: current_client, invite_key: session[:invitation_key])

      session[:invitation_key] = nil if result.success?
    end
  end

  def set_organization
    autorization @organization
  end
end
