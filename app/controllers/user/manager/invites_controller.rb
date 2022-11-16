# frozen_string_literal: true

class User::Manager::InvitationsController < User::Manager::ManagerController
  before_action :set_group
  before_action :set_invitation, only: [:destroy]

  def create
    result = ::Provider::Invitations::Create.result(
      attributes: {
        organization: current_user.decorate.provider, group: @group, role_type: 'customer'
      }
    )

    if result.success?
      redirect_to user_manager_group_accessibilities_path(@group), notice: 'criado'
    else
      redirect_to user_manager_group_accessibilities_path(@group), alert: result.error
    end
  end

  def destroy
    result = ::Provider::Invitations::Update.result(
      invitation: @invitation
    )

    if result.success?
      redirect_to user_manager_group_accessibilities_path(@group), notice: 'removido'
    else
      redirect_to user_manager_group_accessibilities_path(@group), alert: result.error
    end
  end

  private

  def set_invitation
    @invitation = policy_class(Invitation).find(params[:id])
  end

  def set_group
    @group = policy_scope(Group).friendly.find(params[:group_id])
  end
end
