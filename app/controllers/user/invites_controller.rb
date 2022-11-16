# frozen_string_literal: true

class User::InvitesController < User::UserController
  before_action :set_invite, only: %i[destroy]

  def index
    @q = policy_scope(Invite).where(organization: current_user.decorate.provider, project: nil).where.not(role_type: 'customer').ransack(params[:q])
    result = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @invites = pagy(result, items: 10)
  end

  def new
    @invite = Invite.new
  end
  
  def create
    result = ::Users::Invites::Create.result(
      attributes: invites_params
    )

    if result.success?
      redirect_to user_provider_invites_path, notice: 'criado'
    else
      redirect_to user_provider_invites_path, alert: result.error
    end
  end

  def destroy
    result = ::Users::Invites::Destroy.result(
      invite: @invite
    )

    if result.success?
      redirect_to user_provider_invites_path, notice: 'removido'
    else
      redirect_to user_provider_invites_path, alert: result.error
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:role_type, :email)
      .merge(organization: current_user.decorate.provider).to_h
  end

  def set_invite
    @invite = policy_class(Invite).find(params[:id])
  end
end
