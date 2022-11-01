# frozen_string_literal: true

class User::Provider::Manager::TasksController < User::Provider::Manager::ManagerController
  before_action :set_task
  before_action :set_message, except: %i[create]

  def create
    result = ::Provider::Manager::Messages::Create.result(
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

  def destroy
    result = ::Provider::Manager::Messages::Destroy.result(
      task: @task
    )

    if result.success?
      
    else
    
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :description, :folder_id, :link, files: [])
      .merge(creator: current_user, type_task: 'activity', project: @project).to_h
  end

  def set_message
    @message = policy_scope(Message).friendly.find(params[:message_id])
  end

  def set_task
    @task = policy_scope(Task).friendly.find(params[:task_id])
  end
end
