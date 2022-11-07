# frozen_string_literal: true

class User::Provider::InvitationLinksController < User::Provider::ProviderController
  before_action :set_invitation_link, only: %i[destroy]

  def index
    @invitation_links = policy_scope(InvitationLink).where(organization: current_user.decorate.provider)
  end

  def create
    result = ::Provider::InvitationLinks::Create.result(
      attributes: invitations_params
    )

    if result.success?
      redirect_to user_provider_invitations_path, notice: 'criado'
    else
      redirect_to user_provider_invitations_path, alert: result.error
    end
  end

  def destroy
    result = ::Provider::InvitationLinks::Destroy.result(
      invitation_link: @invitation_link
    )

    if result.success?
      redirect_to user_provider_invitations_path, notice: 'removido'
    else
      redirect_to user_provider_invitations_path, alert: result.error
    end
  end

  private

  def invitation_link_params
    params.require(:invitation_link).permit(:role_type)
      .merge(organization: current_user.decorate.provider).to_h
  end

  def set_invitation_link
    @invitation_link = policy_class(InvitationLink).find(params[:id])
  end
end
