# frozen_string_literal: true

class User::Provider::Manager::FoldersController < User::Provider::Manager::ManagerController
  before_action :set_project
  before_action :set_folder, except: %i[index new create]

  def index
    @folders = policy_scope(Folder).where(project: @project)

    @q = policy_scope(Task).where(project: @project, folder: nil).ransack(params[:q])
    result = @q.result(distinct: true).order(title: :asc)
    @pagy, @tasks = pagy(result, items: 10)
  end

  def new
    @folder = Folder.new
  end

  def show
    @folders = @folder.foldables

    @q = policy_scope(Task).where(project: @project, folder: @folder).ransack(params[:qt])
    result = @q.result(distinct: true).order(title: :asc)
    @pagy, @tasks = pagy(result, items: 10)
  end

  def edit; end

  def create
    result = ::Provider::Manager::Folders::Create.result(
      customer: @customer,
      attributes: folder_params
    )

    if result.success?
      if result.folder.foldable.present?
        redirect_to user_provider_manager_project_folder_path(@project, result.folder.foldable), notice: 'atualizado'
      else
        redirect_to user_provider_manager_project_folders_path(@project), notice: 'atualizado'
      end
    else
      @message_error = result.error
      @folder = result.folder

      render :new, status: :unprocessable_entity 
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
      @message_error = result.error
      @folder = result.folder

      render :edit, status: :unprocessable_entity 
    end
  end

  def move_to
  end

  private

  def folder_params
    params.require(:folder).permit(:title, :foldable_id).merge(project: @project).to_h
  end

  def set_folder
    @folder = policy_scope(Folder).friendly.find(params[:id])
  end

  def set_project
    @project = policy_scope(Project).friendly.find(params[:project_id])
  end
end
