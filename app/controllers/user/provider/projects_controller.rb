# frozen_string_literal: true

class User::Provider::ProjectsController < User::Provider::ProviderController
  before_action :set_project, only: %i[edit update destroy]

  def index
    @q = policy_scope(Project).ransack(params[:q])
    result = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @projects = pagy(result, items: 10)
  end

  def new
    @project = Project.new
    @project_notifications = @project.project_notifications.build
  end
  def create
    result = ::Provider::Projects::Create.result(
      attributes: project_params
    )

    if result.success?
      redirect_to user_provider_manager_project_folders_path(result.project), notice: 'criado'
    else
      flash[:alert] = result.error

      render :new
    end
  end

  def update
    result = ::Provider::Projects::Update.result(
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
    params.require(:project).permit(
      :title, :user_ids, project_notifications: [:receive_email_when_tagged, :receive_email_when_client_responds]
    ).merge(customer: @customer).to_h
  end

  def set_project
    @project = policy_class(Project).friendly.find(params[:id])
  end
end
