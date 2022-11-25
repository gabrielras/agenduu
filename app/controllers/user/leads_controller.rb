# frozen_string_literal: true

class User::LeadsController < UserController
  before_action :set_lead, only: %i[destroy]

  def index
    @lead = organization.lead
  end

  def new
    @lead = Lead.new
  end

  def edit; end

  def create
    result = ::Users::Leads::Create.result(
      attributes: leads_params
    )

    if result.success?
      redirect_to user_leads_path, notice: 'criado'
    else
      redirect_to user_leads_path, alert: result.error
    end
  end

  def update
    result = ::Users::Leads::Update.result(
      attributes: leads_params,
      lead: @lead
    )

    if result.success?
      redirect_to user_leads_path, notice: 'criado'
    else
      redirect_to user_leads_path, alert: result.error
    end
  end

  def destroy
    result = ::Users::Leads::Destroy.result(lead: @lead)

    if result.success?
      redirect_to user_leads_path, notice: 'removido'
    else
      redirect_to user_leads_path, alert: result.error
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:full_name, :email, :phone_number)
      .merge(organization: current_user.organization).to_h
  end

  def set_lead
    @lead = policy_scope(Lead).find(params[:id])
  end
end
