# frozen_string_literal: true

class User::Provider::Manager::CustomersController < User::Provider::Manager::ManagerController
  include OrganizationsHelper
  before_action :set_customer, only: %i[edit update]

  def index
    @q = policy_scope(Organization).ransack(params[:q])
    result = @q.result(distinct: true)
    @pagy, @customers = pagy(result, items: 10)
  end

  def new
    @customer = Organization.new
  end

  def edit; end

  def create
    result = ::Provider::Manager::Customers::Create.result(
      provider: provider,
      attributes: customer_params
    )

    if result.success?
      redirect_to user_provider_manager_customer_folders_path(result.customer),
                  notice: 'Organização do cliente criada'
    else
      flash[:alert] = result.error
      @customer = result.customer

      render :new
    end
  end

  def update
    result = ::Provider::Manager::Customers::Update.result(
      customer: @customer,
      attributes: customer_params
    )

    if result.success?
      redirect_to user_provider_curstumer_path(result.medical_record),
                  notice: 'Organização do cliente atualizada'
    else
      flash[:alert] = result.error

      render :edit
    end
  end

  private

  def set_customer
    @customer = policy_scope(Organization).friendly.find(params[:id])

    authorize @customer
  end

  def customer_params
    params.require(:organization).permit(
      :title, :email, :phone_number, :primary_color, :second_color, :project_first_title
    ).to_h
  end
end
