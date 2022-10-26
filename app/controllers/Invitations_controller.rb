# frozen_string_literal: true

class InvitationsController < ApplicationController
  layout 'devise'

  def confirmation
    @email_security_key = params[:id]
  end

  def authorize
    result = ::Common::Users::AuthorizeInvitation.result(
      email_security_key: params[:email_security_key],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    if result.success?
      sign_in(:user, result.user)

      redirect_to user_common_dashboards_path, notice: 'Senha atualizada com sucesso.'
    else
      flash[:alert] = result.error

      render :confirmation
    end
  end
end
