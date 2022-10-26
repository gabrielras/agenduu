# frozen_string_literal: true

class User::Provider::RolesController < User::Provider::ProviderController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @q = policy_scope(User).ransack(params[:q])
    result = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @users = pagy(result, items: 10)
  end

  def new
    @user = User.new
    @roles = @user.roles.build
  end

  def create
    result = ::Provider::Roles::Create.result(
      attributes: user_params
    )

    if result.success?
      redirect_to user_provider_roles_path(result.user), notice: 'criado'
    else
      flash[:alert] = result.error
      @user = result.user

      render :new
    end
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
      :full_name, :email, role: [:role_type].merge(organization_id: current_user.decorate.provider)
    ).to_h
  end

  def set_user
    @user = policy_class(Project).friendly.find(params[:id])
  end
end
