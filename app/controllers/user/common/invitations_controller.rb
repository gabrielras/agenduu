# frozen_string_literal: true

class User::Common::InvitationsController < AbsentUserController
  layout 'common'

  def index
    @email_security_key = params[:id]
  end

  def confirm
    result = ::Common::Users::AuthorizeInvitation.result(
      email_security_key: params[:email_security_key]
    )

    if result.success?
      sign_in(:user, result.user)

      redirect_to user_common_dashboards_path, notice: 'Senha atualizada com sucesso.'
    else
      flash[:alert] = result.error

      render :confirmation
    end
  end

  def reject
    result = ::Common::Users::AuthorizeInvitation.result(
      email_security_key: params[:email_security_key]
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
