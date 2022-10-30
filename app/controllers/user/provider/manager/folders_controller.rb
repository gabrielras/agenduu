# frozen_string_literal: true

class User::Provider::Manager::FoldersController < User::Provider::Manager::ManagerController
  before_action :set_project
  before_action :set_folder, only: %i[edit update]

  def index
    @q = policy_scope(Folder).where(project: @project).ransack(params[:q])
    result = @q.result(distinct: true).order(title: :asc)
    @pagy, @meetings = pagy(result, items: 10)
  end

  def show
  end

  def create
    result = ::Provider::Manager::Folders::Create.result(
      customer: @customer,
      attributes: folder_params
    )

    if result.success?
      redirect_to (result.folder), notice: 'Registro médico criado'
    else
      flash[:alert] = result.error

      render :new
    end
  end

  def update
    result = ::Provider::Manager::Folders::Update.result(
      folder: @folder,
      attributes: folder_params
    )

    if result.success?
      if result.folder.foldable.present?
        redirect_to user_provider_manager_project_folder_path(@project, result.folder.foldable), notice: 'atualizado'
      else
        redirect_to user_provider_manager_project_folders_path(@project), notice: 'atualizado'
      end
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  def move_to
    result = ::Provider::Manager::Folders::MoveTo.result(
      folder: @folder,
      attributes: folder_params
    )

    if result.success?
      redirect_to (result.folder), notice: 'Registro médico criado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  def move_to
  end

  private

  def folder_params
    params.require(:folder).permit(:title, :foldable_id).to_h
  end

  def set_folder
    @folder = policy_scope(Folder).friendly.find(params[:id])
  end

  def set_project
    @project = policy_scope(Project).friendly.find(params[:project_id])
  end
end
