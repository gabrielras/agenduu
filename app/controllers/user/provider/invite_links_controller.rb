# frozen_string_literal: true

class User::Provider::InviteLinksController < User::Provider::ProviderController
  before_action :set_invite_link, only: %i[destroy]

  def index
    @invite_links = policy_scope(InviteLink).where(organization: current_user.decorate.provider)
  end

  def create
    result = ::Provider::InviteLinks::Create.result(
      attributes: invite_link_params
    )

    if result.success?
      redirect_to user_provider_invitations_path, notice: 'criado'
    else
      redirect_to user_provider_invitations_path, alert: result.error
    end
  end

  def destroy
    result = ::Provider::InviteLinks::Destroy.result(
      invite_link: @invite_link
    )

    if result.success?
      redirect_to user_provider_invitations_path, notice: 'removido'
    else
      redirect_to user_provider_invitations_path, alert: result.error
    end
  end

  private

  def invite_link_params
    params.require(:invite_link).permit(:role_type)
      .merge(organization: current_user.decorate.provider).to_h
  end

  def set_invite_link
    @invite_link = policy_class(InviteLink).find(params[:id])
  end
end
