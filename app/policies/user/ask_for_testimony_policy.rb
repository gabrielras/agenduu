# frozen_string_literal: true

class User::AskForTestimonyPolicy < ApplicationPolicy
  def edit?
    user.role.owner? || user.role.admin?
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
      scope.joins(:organization).where(organization: { id: user.organization.id })
    end

    private

    attr_reader :user, :scope
  end
end
