# frozen_string_literal: true

class User::Provider::Manager::NotificationsController < User::Provider::Manager::ManagerController
  before_action :set_project
  before_action :set_accessibility_notification, except: [:index]

  def index
    @accessibility_notification = AccessibilityNotification.joins(:accessibility).where(accessibility: { project: @project, user: current_user }).take

    @q = Notification.where(project: @project, user: current_user).ransack(params[:q])
    result = @q.result(distinct: true).order(description: :asc)
    @pagy, @notfications = pagy(result, items: 10)
  end

  def edit; end

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

  private

  def accessibility_notification_params
    params.require(:accessibility_notification).permit(:title, :foldable_id).merge(project: @project).to_h
  end

  def set_accessibility_notification
    @accessibility_notification = policy_scope(AccessibilityNotification).find(params[:id])
  end

  def set_project
    @project = policy_scope(Project).friendly.find(params[:project_id])
  end
end
