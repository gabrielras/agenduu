# frozen_string_literal: true

class User::Provider::Manager::ProjectPolicy < ApplicationPolicy
  def show?
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
      scope.joins(customer: [provider: :users]).where(users: { id: user.id})
    end

    private

    attr_reader :user, :scope
  end
end
