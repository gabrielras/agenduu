# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  def list_users
    provider.users.where(id: object.id).order(:full_name).uniq
  end

  def role
    object.roles.where.not(role_type: %w[customer]).take
  end

  def in_provider?
    object.roles.where.not(role_type: %w[customer]).present?
  end

  def provider
    role.organization
  end  
end
