# frozen_string_literal: true

class User::Provider::CustomersController < User::Provider::ProviderController
  include OrganizationsHelper
  before_action :set_customer, only: %i[destroy]

  def index
    @q = policy_scope(User).joins(:roles).where(roles: { role_type: 'customer'}).ransack(params[:q])
    result = @q.result(distinct: true)
    @pagy, @users = pagy(result, items: 10)
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
end
