# frozen_string_literal: true

class User::Provider::ProvidersController < User::Provider::ProviderController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @q = policy_scope(User).joins(:roles).where.not(roles: { role_type: 'customer'}).ransack(params[:q])
    result = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @users = pagy(result, items: 10)
  end

  def update
    result = ::Provider::Roles::Update.result(
      user: @user,
      attributes: user_params
    )

    if result.success?
      redirect_to edit_user_provider_role_path(result.user), notice: 'atualizado'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  def destroy
    result = ::Provider::Roles::Destroy.result(
      user: @user,
      attributes: user_params
    )

    if result.success?
      redirect_to user_provider_users_path, notice: 'Removido'
    else
      flash[:alert] = result.error

      render :edit
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
