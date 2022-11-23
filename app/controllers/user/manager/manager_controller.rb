# frozen_string_literal: true

class User::Manager::ManagerController < ApplicationController
  before_action :authenticate_user!, :confirm_invite, :authorize_organization

  def policy_scope(scope)
    super([:user, :manager, scope])
  end

  def authorize(record, query = nil)
    super([:user, :manager, record], query)
  end

  private

  def confirm_invite
    if session[:invitation_key].present?
      result = Users::Invites::Confirm.result(user: current_user, invite_key: session[:invitation_key])

      session[:invitation_key] = nil if result.success?
    end
  end

  def authorize_organization
    return if controller_path.include?('user/environments')

    authorize(organization) 
  end
end