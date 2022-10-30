# frozen_string_literal: true

class User::Provider::CustomersController < User::Provider::ProviderController
  include OrganizationsHelper
  before_action :set_customer, only: %i[destroy]

  def index
    @q = policy_scope(User).joins(:roles).where(roles: { role_type: 'customer'}).ransack(params[:q])
    result = @q.result(distinct: true)
    @pagy, @users = pagy(result, items: 10)
  end

  def new
    @user = User.new
  end

  def create
    result = ::Provider::Roles::Create.result(
      current_user: current_user, attributes: customer_params
    )

    if result.success?
      redirect_to user_provider_customers_path,
                  notice: 'Cliente criado'
    else
      @message_error = result.error
      @user = result.user

      render :new, status: :unprocessable_entity 
    end
  end

  def destroy
    result = ::Provider::Roles::Destroy.result(
      user: @user, current_user: current_user
    )

    if result.success?
      redirect_to user_provider_customers_path,
                  notice: 'Cliente removido'
    else
      redirect_to user_provider_customers_path, alert: result.error
    end
  end

  private

  def set_customer
    @user = policy_scope(User).friendly.find(params[:id])

    authorize @user
  end

  def customer_params
    params.require(:user).permit(:full_name, :email)
      .merge(role: { role_type: 'customer' }).to_h
  end
end
