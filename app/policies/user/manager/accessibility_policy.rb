# frozen_string_literal: true

class Users::Manager::AccessibilityPolicy < ApplicationPolicy
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

  def destroy?
    true
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(project: :organization).where(organization: { id: user.decorate.provider.id })
    end

    private

    attr_reader :user, :scope
  end
end
