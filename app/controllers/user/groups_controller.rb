# frozen_string_literal: true

class User::GroupsController < UserController
  before_action :set_group, only: %i[edit update destroy]

  def index
    @q = policy_scope(Group).ransack(params[:q])
    result = @q.result(distinct: true).includes(:creator).order(created_at: :desc)
    @pagy, @groups = pagy(result, items: 10)
  end

  def new
    @group = Group.new
  end

  def create
    result = ::Users::Groups::Create.result(
      current_user: current_user,
      attributes: group_params
    )

    if result.success?
      redirect_to user_manager_groups_path(result.group), notice: 'criado'
    else
      @message_error = result.error
      @group = result.group

      render :new, status: :unprocessable_entity 
    end
  end

  def update
    result = ::Users::Groups::Update.result(
      current_user: current_user,
      group: @group,
      attributes: group_params
    )

    if result.success?
      redirect_to edit_user_group_path(result.group), notice: 'atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  def destroy
    result = ::Users::Groups::Update.result(
      group: @group,
      attributes: group_params
    )

    if result.success?
      redirect_to user_groups_path, notice: 'Removido'
    else
      redirect_to user_groups_path, alert: result.error
    end
  end

  private

  def group_params
    params.require(:group).permit(:title).merge(organization: current_user.decorate.organization).to_h
  end

  def set_group
    @group = policy_class(Group).friendly.find(params[:id])
  end
end
