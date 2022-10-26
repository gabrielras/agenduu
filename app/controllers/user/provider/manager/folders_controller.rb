# frozen_string_literal: true

class User::Provider::Manager::FoldersController < User::Provider::Manager::ManagerController
  before_action :set_customer, :set_project
  before_action :set_folder, only: %i[edit update]

  def index
    @q = policy_scope(Folder).where(project: @project).ransack(params[:q])
    result = @q.result(distinct: true).order(title: :asc)
    @pagy, @meetings = pagy(result, items: 10)
  end

  def show
  end

  def create
    result = ::Provider::Folders::Create.result(
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
    result = ::Provider::Folders::Update.result(
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
    params.require(:folder).permit(:title, :archivable_id).to_h
  end

  def set_folder
    @folder = Folder.where(customer: @customer).friendly.find(params[:id])
  end

  def set_customer
    @customer = policy_class(Organization).friendly.find(params[:customer_id])
  end

  def set_project
    @project = policy_class(Project).friendly.find(params[:customer_id])
  end
end
