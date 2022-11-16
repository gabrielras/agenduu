# frozen_string_literal: true

class User::Manager::TasksController < User::Manager::ManagerController
  before_action :set_project
  before_action :set_task, except: %i[index new create]

  def index
    @q = policy_scope(Task).where(project: @project).ransack(params[:q])
    result = @q.result(distinct: true).order(title: :asc)
    @pagy, @tasks = pagy(result, items: 10)
  end

  def new
    @folder = params[:folder_id].present? ? policy_scope(Folder).friendly.find(params[:folder_id]) : nil
    @task = Task.new
  end

  def show
    @messages = @task.messages
  end

  def edit
    @folder = params[:folder_id].present? ? policy_scope(Folder).friendly.find(params[:folder_id]) : nil
  end

  def create
    result = ::Provider::Manager::Tasks::Create.result(
      attributes: task_params
    )

    if result.success?
      redirect_to user_provider_manager_project_task_path(@project, result.task), notice: 'atualizado'
    else
      @message_error = result.error
      @task = result.task

      render :new, status: :unprocessable_entity 
    end
  end

  def update
    result = ::Provider::Manager::Tasks::Update.result(
      task: @task,
      attributes: task_params
    )

    if result.success?
      if result.task.foldable.present?
        redirect_to user_provider_manager_project_task_path(@project, result.task.foldable), notice: 'atualizado'
      else
        redirect_to user_provider_manager_project_tasks_path(@project), notice: 'atualizado'
      end
    else
      @message_error = result.error
      @task = result.task

      render :edit, status: :unprocessable_entity 
    end
  end

  def move_to
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :folder_id, :link, files: [])
      .merge(creator: current_user, type_task: 'activity', project: @project).to_h
  end

  def set_task
    @task = policy_scope(Task).friendly.find(params[:id])
  end

  def set_group
    @group = policy_scope(Group).friendly.find(params[:group_id])
  end
end
