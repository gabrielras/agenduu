# frozen_string_literal: true

class User::Common::AuthorizationsController < AbsentUserController
  layout 'common'

  def confirmation
    @email_security_key = params[:id]
  end

  def authorize
    result = ::Common::Users::Authorization.result(
      email_security_key: params[:email_security_key]
    )

    if result.success?
      redirect_to 
    else
      flash[:alert] = result.error

      render :confirmation
    end
  end
end
