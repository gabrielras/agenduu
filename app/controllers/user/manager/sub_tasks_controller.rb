# frozen_string_literal: true

class User::Manager::SubTasksController < User::Manager::ManagerController
  before_action :set_group, :set_task
  before_action :set_sub_task, except: %i[create]

  def create
    result = Users::Manager::SubTasks::Create.result(
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
    result = Users::Manager::SubTasks::Update.result(
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
    result = Users::Manager::Tasks::Update.result(sub_task: @sub_task)

    if result.success?
      redirect_to user_manager_group_task_sub_tasks_path(@group, @task), notice: 'removido'
    else
      redirect_to user_manager_group_task_sub_tasks_path(@group, @task), alert: result.error
    end
  end

  private

  def sub_task_params
    params.require(:sub_task).permit(:title).merge(creator: current_user, task_id: @task.id).to_h
  end

  def set_sub_task
    @sub_task = policy_scope(SubTask).find(params[:id])
  end

  def set_task
    @task = policy_scope(Task).friendly.find(params[:id])
  end

  def set_group
    @group = policy_scope(Group).friendly.find(params[:group_id])
  end
end
