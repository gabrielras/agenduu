# frozen_string_literal: true

class User::Manager::InvitePolicy < ApplicationPolicy
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
