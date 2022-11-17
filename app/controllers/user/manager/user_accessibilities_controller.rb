# frozen_string_literal: true

class User::Manager::AccessibilitiesController < User::Manager::ManagerController
  before_action :set_project
  before_action :set_accessibility, except: [:index, :create, :new]

  def index
    @q = policy_scope(Accessibility).where(project: @project).joins(:roles).where.not(roles: { role_type: 'customer' }).ransack(params[:q])
    result = @q.result(distinct: true).includes(:project, :user).order(description: :asc)
    @pagy, @accessibilities = pagy(result, items: 10)
  end

  def new
    @accessibility = Accessibility.new
  end

  def edit; end

  def update
    result = ::Users::Manager::Accessibility::Employees::Update.result(
      accessibility: @accessibility,
      attributes: accessibility_params
    )

    if result.success?
      redirect_to user_provider_manager_project_folder_path(@project, result.folder.foldable), notice: 'atualizado'
    else
      @message_error = result.error
      @accessibility = result.accessibility

      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    result = ::Users::Manager::Accessibility::Employees::Destroy.result(
      folder: @accessibility
    )

    if result.success?
      
    else
      
    end
  end

  private

  def accessibility_params
    params.require(:accessibility).permit(:user_id, :allows).merge(project: @project).to_h
  end

  def set_accessibility
    @accessibility = policy_scope(Accessibility).find(params[:id])
  end

  def set_group
    @group = policy_scope(Group).friendly.find(params[:group_id])
  end
end
