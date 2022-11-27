# frozen_string_literal: true

class User::AwardPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    user.role.owner? || user.role.admin?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

  def show?
    new?
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(:organization).where(organization: { id: user.organization.id })
    end

    private

    attr_reader :user, :scope
  end
end
