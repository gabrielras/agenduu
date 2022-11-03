# frozen_string_literal: true

class User::Provider::Manager::AccessibilityForCustomersController < User::Provider::Manager::ManagerController
  before_action :set_project
  before_action :set_accessibility, except: [:index, :create, :new]

  def index
    @q = policy_scope(Accessibility).where(project: @project).joins(:roles).where(roles: { role_type: 'customer' }).ransack(params[:q])
    result = @q.result(distinct: true).includes(:project, :user).order(description: :asc)
    @pagy, @accessibilities = pagy(result, items: 10)
  end

  def new
    @accessibility = Accessibility.new

    @users = policy_scope(User).joins(:roles).where(roles: { role_type: 'customer'})
  end

  def edit; end

  def create
    result = ::Provider::Manager::Accessibility::Customers::Create.result(
      attributes: accessibility_params
    )

    if result.success?
      redirect_to user_provider_manager_project_folder_path(@project, result.folder.foldable), notice: 'atualizado'
    else
      @message_error = result.error
      @accessibility = result.accessibility

      render :new, status: :unprocessable_entity 
    end
  end

  def update
    result = ::Provider::Manager::Accessibility::Customers::Update.result(
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
    result = ::Provider::Manager::Accessibility::Customers::Destroy.result(
      folder: @accessibility
    )

    if result.success?
      
    else
      
    end
  end

  private

  def accessibility_params
    params.require(:accessibility).permit(:user_id, :allows, :email, :full_name).merge(project: @project).to_h
  end

  def set_accessibility
    @accessibility = policy_scope(Accessibility).find(params[:id])
  end

  def set_project
    @project = policy_scope(Project).friendly.find(params[:project_id])
  end
end
