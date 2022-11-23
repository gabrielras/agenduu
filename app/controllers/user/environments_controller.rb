# frozen_string_literal: true

class User::EnvironmentsController < UserController
  def index
    redirect_to user_dashboards_path(subdomain: current_user.organization.slug) if current_user.role.present?
  end
end
