# frozen_string_literal: true

class User::Common::AuthorizationsController < AbsentUserController
  layout 'common'

  def index; end

  def new
    @email_security_key = params[:id]
  end

  def create
    result = ::Common::Users::Authorization.result(
      email_security_key: params[:email_security_key]
    )

    if result.success?
      redirect_to user_common_invitations_path, notice: 'Autorizado com sucesso!'
    else
      flash[:alert] = result.error
      @email_security_key = result.email_security_key

      render :new
    end
  end
end
