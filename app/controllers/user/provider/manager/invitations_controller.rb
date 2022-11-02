# frozen_string_literal: true

class User::Provider::Manager::InvitationsController < User::Provider::Manager::ManagerController
  before_action :set_project
  before_action :set_invitation, only: [:destroy]

  def create
    result = ::Provider::Invitations::Create.result(
      attributes: {
        organization: current_user.decorate.provider, project: @project, role_type: 'customer'
      }
    )

    if result.success?
      redirect_to user_provider_manager_project_accessibilities_path(@project), notice: 'criado'
    else
      redirect_to user_provider_manager_project_accessibilities_path(@project), alert: result.error
    end
  end

  def destroy
    result = ::Provider::Invitations::Update.result(
      invitation: @invitation
    )

    if result.success?
      redirect_to user_provider_manager_project_accessibilities_path(@project), notice: 'removido'
    else
      redirect_to user_provider_manager_project_accessibilities_path(@project), alert: result.error
    end
  end

  private

  def set_invitation
    @invitation = policy_class(Invitation).find(params[:id])
  end

  def set_project
    @project = policy_scope(Project).friendly.find(params[:project_id])
  end
end
