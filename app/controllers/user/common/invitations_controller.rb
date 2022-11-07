# frozen_string_literal: true

class User::Common::InvitationsController < AbsentUserController
  layout 'common'

  def index
    @invitations = Invitation.where(email: current_user.email)
  end

  def confirm
    result = ::Common::Invitations::Confirm.result(
      user: current_user,
      invitation: Invitation.find(params[:id])
    )

    if result.success?
      redirect_to user_common_invitations_path, notice: 'Confirmado'
    else
      redirect_to user_common_invitations_path, alert: result.error
    end
  end

  def reject
    result = ::Common::Invitations::Rejected.result(
      user: current_user,
      invitation: Invitation.find(params[:id])
    )

    if result.success?
      redirect_to user_common_invitations_path, notice: 'Rejeitado'
    else
      redirect_to user_common_invitations_path, alert: result.error
    end
  end
end
