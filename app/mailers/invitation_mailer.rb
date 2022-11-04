# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def organization
    @organization = params[:organization]
    @email = params[:email]

    mail to: @email, subject: 'Confirme seu email'
  end

  def project
    @project = params[:project]
    @email = params[:email]

    mail to: @email, subject: 'Confirme seu email'
  end
end
