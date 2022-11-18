# frozen_string_literal: true

class Users::ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def edit?
    user.role.owner? || user.role.admin? || record.creator == user
  end

  def update?
    edit?
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(:organization).where(organization: { id: user.decorate.provider.id })
    end

    private

    attr_reader :user, :scope
  end
end
