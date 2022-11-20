# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!, :confirm_invite, :set_organization

  def policy_scope(scope)
    super([:user, scope])
  end

  def authorize(record, query = nil)
    super([:user, record], query)
  end

  private

  def confirm_invite
    if session[:invitation_key].present?
      result = Users::Invites::Confirm.result(user: current_user, invite_key: session[:invitation_key])

      session[:invitation_key] = nil if result.success?
    end
  end

  def set_organization
    return if @organization.blank?

    authorize([:user, @organization]) 
  end
end
