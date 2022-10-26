# frozen_string_literal: true

class User::Provider::Manager::CustomerPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(provider: :users).where(users: { id: user.id})
    end

    private

    attr_reader :user, :scope
  end
end
