# frozen_string_literal: true

class User::Provider::ProviderPolicy < ApplicationPolicy
  def index?
    user.role.owner? || user.role.admin?
  end

  def create?
    index?
  end

  def new?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def destroy?
    true
  end
end
