# frozen_string_literal: true

class User::Provider::Manager::AccessibilityNotificationPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
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
      scope.joins(accessibility: :user).where(user: { id: user.id })
    end

    private

    attr_reader :user, :scope
  end
end

