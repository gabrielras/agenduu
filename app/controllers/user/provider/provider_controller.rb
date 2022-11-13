# frozen_string_literal: true

class User::Provider::ProviderController < UserController
  before_action :validate_organization, :set_organization

  def policy_scope(scope)
    super([:user, :provider, scope])
  end

  def authorize(record, query = nil)
    super([:user, :provider, record], query)
  end

  def set_organization
    @organization = policy_scope(Organization).find_by!(slug: request.subdomain)
  end

  private

  def validate_organization
    return if controller_path.include?('user/provider/organizations') || current_user.decorate.in_provider?

    redirect_to new_user_provider_organization_path, alert: 'Antes de continuar, cadastre sua empresa'
  rescue
    redirect_to new_user_provider_organization_path, alert: 'Antes de continuar, cadastre sua empresa'
  end
end