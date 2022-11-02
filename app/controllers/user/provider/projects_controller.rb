# frozen_string_literal: true

class User::Provider::ProjectsController < User::Provider::ProviderController
  before_action :set_project, only: %i[edit update destroy]

  def index
    @q = policy_scope(Project).ransack(params[:q])
    result = @q.result(distinct: true).includes(:creator).order(created_at: :desc)
    @pagy, @projects = pagy(result, items: 10)
  end

  def new
    @project = Project.new
  end

  def create
    result = ::Provider::Projects::Create.result(
      current_user: current_user,
      attributes: project_params
    )

    if result.success?
      redirect_to user_provider_manager_project_folders_path(result.project), notice: 'criado'
    else
      @message_error = result.error
      @project = result.project

      render :new, status: :unprocessable_entity 
    end
  end

  def update
    result = ::Provider::Projects::Update.result(
      current_user: current_user,
      project: @project,
      attributes: project_params
    )

    if result.success?
      redirect_to edit_user_provider_project_path(result.project), notice: 'atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  def destroy
    result = ::Provider::Projects::Update.result(
      project: @project,
      attributes: project_params
    )

    if result.success?
      redirect_to user_provider_projects_path, notice: 'Removido'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(:title).merge(organization: current_user.decorate.provider).to_h
  end

  def set_project
    @project = policy_class(Project).friendly.find(params[:id])
  end
end
