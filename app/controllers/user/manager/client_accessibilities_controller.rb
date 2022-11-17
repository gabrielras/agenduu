# frozen_string_literal: true

class User::Manager::ClientsController < User::Manager::ManagerController
  before_action :set_project
  before_action :set_accessibility, except: [:index, :create, :new]

  def index
    @q = policy_scope(Accessibility).where(project: @project).joins(:roles).where(roles: { role_type: 'customer' }).ransack(params[:q])
    result = @q.result(distinct: true).includes(:project, :user).order(description: :asc)
    @pagy, @accessibilities = pagy(result, items: 10)
  end

  def destroy
    result = ::Users::Manager::Accessibility::Destroy.result(
      folder: @accessibility
    )

    if result.success?
      
    else
      
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
