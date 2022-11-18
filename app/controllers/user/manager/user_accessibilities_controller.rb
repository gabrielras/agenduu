# frozen_string_literal: true

class User::Manager::AccessibilitiesController < User::Manager::ManagerController
  before_action :set_group
  before_action :set_accessibility, except: [:index, :create, :new]

  def index
    @q = policy_scope(UserAccessibility).where(group: @group).ransack(params[:q])
    result = @q.result(distinct: true).includes(:group, :user).order(description: :asc)
    @pagy, @accessibilities = pagy(result, items: 10)
  end

  def new
    @accessibility = Accessibility.new
  end

  def edit; end

  def update
    result = ::Users::Manager::UserAccessibilities::Update.result(
      accessibility: @accessibility,
      attributes: accessibility_params
    )

    if result.success?
      redirect_to user_manager_user_accessibilities_path(@group), notice: 'atualizado'
    else
      @message_error = result.error
      @accessibility = result.accessibility

      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    result = ::Users::Manager::UserAccessibilities::Destroy.result(
      accessibility: @accessibility
    )

    if result.success?
      redirect_to user_manager_user_accessibilities_path(@group), notice: 'removido'
    else
      redirect_to user_manager_user_accessibilities_path(@group), alert: result.error
    end
  end

  private

  def accessibility_params
    params.require(:accessibility).permit(:user_id, :allows).merge(group: @group).to_h
  end

  def set_accessibility
    @accessibility = policy_scope(UserAccessibility).find(params[:id])
  end

  def set_group
    @group = policy_scope(Group).friendly.find(params[:group_id])
  end
end
