# frozen_string_literal: true

class User::UserPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(:roles).where(roles: { organization_id: user.decorate.provider.id })
    end

    private

    attr_reader :user, :scope
  end
end
