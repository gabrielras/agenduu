# frozen_string_literal: true

class User::Common::AuthorizationsController < AbsentUserController
  layout 'common'

  def index; end

  def new
    result = ::Common::Users::Authorization.result(
      email_security_key: session[:email_security_key]
    )

    if result.success?
      redirect_to user_common_invitations_path, notice: 'Autorizado com sucesso!'
    else
      redirect_to user_common_authorizations_path, alert: result.error
    end
  end
end
