# frozen_string_literal: true

class ClientController < ApplicationController
  before_action :authenticate_client!, :policy_organization

  private

  def policy_organization
    unless organization == current_client.organization
      raise Pundit::NotAuthorizedError, "Erro de Autorização"
    end
  end

  def organization
    @organization = Organization.find_by!(slug: request.subdomain)
  end
end
