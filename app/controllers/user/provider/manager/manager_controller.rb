# frozen_string_literal: true

class User::Provider::Manager::ManagerController < UserController
  before_action :validate_organization

  def policy_scope(scope)
    super([:user, :provider, :manager, scope])
  end

  def authorize(record, query = nil)
    super([:user, :provider, :manager, record], query)
  end

  private

  def validate_organization
    return if controller_path.include?('user/provider/organizations') || current_user.decorate.in_provider?

    redirect_to new_user_provider_organization_path, alert: 'Antes de continuar, cadastre sua empresa'
  rescue
    redirect_to new_user_provider_organization_path, alert: 'Antes de continuar, cadastre sua empresa'
  end
end