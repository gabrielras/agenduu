# frozen_string_literal: true

class User::Manager::InvitesController < User::Manager::ManagerController
  before_action :set_group
  before_action :set_invite, only: [:destroy]

  def create
    result = Users::Manager::Invites::Create.result(
      attributes: {
        organization: current_user.organization, group: @group, role_type: 'client'
      }
    )

    if result.success?
      redirect_to user_manager_group_invites_path(@group), notice: 'criado'
    else
      redirect_to user_manager_group_invites_path(@group), alert: result.error
    end
  end

  def destroy
    result = Users::Manager::Invites::Destroy.result(
      invite: @invite
    )

    if result.success?
      redirect_to user_manager_group_invites_path(@group), notice: 'removido'
    else
      redirect_to user_manager_group_invites_path(@group), alert: result.error
    end
  end

  private

  def set_invite
    @invite = policy_class(Invite).find(params[:id])
  end

  def set_group
    @group = policy_scope(Group).friendly.find(params[:group_id])
  end
end
