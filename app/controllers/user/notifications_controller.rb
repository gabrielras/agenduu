# frozen_string_literal: true

class User::LeadsController < UserController
  before_action :set_lead, only: %i[destroy]

  def index
    @lead = organization.lead
  end

  
  private

  def set_lead
    @lead = policy_scope(Lead).find(params[:id])
  end
end
