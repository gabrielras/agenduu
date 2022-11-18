# frozen_string_literal: true

class Users::Manager::OrganizationPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(:roles).where(roles: { user_id: user.id })
    end

    private

    attr_reader :user, :scope
  end
end
