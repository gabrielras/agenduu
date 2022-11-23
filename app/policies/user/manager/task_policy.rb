# frozen_string_literal: true

class User::Manager::TaskPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    true
  end

  def edit?
    true
  end

  def create?
    true
  end

  def update?
    true
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
