# frozen_string_literal: true

class User::UsersController < UserController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @q = policy_scope(User).ransack(params[:q])
    result = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @users = pagy(result, items: 10)
  end

  def update
    result = ::Users::Roles::Update.result(
      user: @user,
      attributes: user_params
    )

    if result.success?
      redirect_to user_users_path, notice: 'atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  def destroy
    result = ::Users::Roles::Destroy.result(
      user: @user,
      attributes: user_params
    )

    if result.success?
      redirect_to user_users_path, notice: 'Removido'
    else
      redirect_to user_users_path, alert: result.error
    end
  end

  private

  def user_params
    params.require(:user).permit(
      role: [:role_type]
    ).to_h
  end

  def set_user
    @user = policy_class(Project).friendly.find(params[:id])
  end
end
