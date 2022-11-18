# frozen_string_literal: true

class User::Manager::TasksController < User::Manager::ManagerController
  before_action :set_group
  before_action :set_task, except: %i[index new create]

  def index
    @q = policy_scope(Task).where(group: @group).ransack(params[:q])
    result = @q.result(distinct: true).order(title: :asc)
    @pagy, @tasks = pagy(result, items: 10)
  end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    result = Users::Manager::Tasks::Create.result(
      attributes: task_params
    )

    if result.success?
      redirect_to edit_user_manager_group_task_path(@group, result.task), notice: 'atualizado'
    else
      @message_error = result.error
      @task = result.task

      render :new, status: :unprocessable_entity 
    end
  end

  def update
    result = Users::Manager::Tasks::Update.result(
      task: @task,
      attributes: task_params
    )

    if result.success?
      redirect_to edit_user_manager_group_task_path(@group, result.task), notice: 'atualizado'
    else
      @message_error = result.error
      @task = result.task

      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    result = Users::Manager::Tasks::Update.result(task: @task)

    if result.success?
      redirect_to user_manager_group_tasks_path(@group), notice: 'removido'
    else
      redirect_to user_manager_group_tasks_path(@group), notice: 'removido'
    end
  end

  private

  def task_params
    params.require(:task).permit(:title).merge(creator: current_user, group: @group).to_h
  end

  def set_task
    @task = policy_scope(Task).friendly.find(params[:id])
  end

  def set_group
    @group = policy_scope(Group).friendly.find(params[:group_id])
  end
end
