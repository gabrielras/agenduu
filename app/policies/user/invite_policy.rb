# frozen_string_literal: true

class Users::InviteLinkPolicy < ApplicationPolicy
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
