# frozen_string_literal: true

class User::Provider::Manager::NotificationPolicy < ApplicationPolicy
   class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(:user).where(user: { id: user.id })
    end

    private

    attr_reader :user, :scope
  end
end

