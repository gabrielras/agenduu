# frozen_string_literal: true

class Client::DashboardsController < ClientController
  def index
    @award = Clients::Awards::Find.result(client: current_client).award
    @rewards = Clients::Rewards::Find.result(client: current_client).rewards

    joins(affiliate: :organization).where(organization: { id: organization.id }, affiliate: { email: current_client.email}).take
  end
end
