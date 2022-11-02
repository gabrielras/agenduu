# frozen_string_literal: true

class User::Provider::InvitationsController < User::Provider::ProviderController
  before_action :set_invitation, only: %i[destroy]

  def index
    @invitations = policy_scope(Invitation).where(project: nil)
  end

  def create
    result = ::Provider::Invitations::Create.result(
      attributes: invitations_params
    )

    if result.success?
      redirect_to user_provider_invitations_path, notice: 'criado'
    else
      redirect_to user_provider_invitations_path, alert: result.error
    end
  end

  def destroy
    result = ::Provider::Invitations::Update.result(
      invitation: @invitation
    )

    if result.success?
      redirect_to user_provider_invitations_path, notice: 'removido'
    else
      redirect_to user_provider_invitations_path, alert: result.error
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:role_type)
      .merge(organization: current_user.decorate.provider).to_h
  end

  def set_invitation
    @invitation = policy_class(Invitation).find(params[:id])
  end
end
