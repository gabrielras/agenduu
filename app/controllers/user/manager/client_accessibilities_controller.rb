# frozen_string_literal: true

class User::Manager::ClientAccessibilitiesController < User::Manager::ManagerController
  before_action :set_group
  before_action :set_accessibility, except: [:index, :create, :new]

  def index
    @q = policy_scope(ClientAccessibility).where(group: @group).ransack(params[:q])
    result = @q.result(distinct: true).includes(:group, :client).order(description: :asc)
    @pagy, @accessibilities = pagy(result, items: 10)
  end

  def destroy
    result = ::Users::Manager::ClientAccessibilities::Destroy.result(
      accessibility: @accessibility
    )

    if result.success?
      redirect_to user_manager_client_accessibilities_path(@group), notice: 'removido'
    else
      redirect_to user_manager_client_accessibilities_path(@group), alert: result.error
    end
  end

  private

  def set_accessibility
    @accessibility = policy_scope(Accessibility).find(params[:id])
  end

  def set_group
    @group = policy_scope(Group).friendly.find(params[:group_id])
  end
end
