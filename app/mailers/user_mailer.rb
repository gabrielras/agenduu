# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def invitation
    @user = params[:user]
    @email_security_key = params[:email_security_key]

    mail to: @user.email, subject: 'Confirme seu email'
  end
end
