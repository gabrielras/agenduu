# frozen_string_literal: true

class User::PageAwardTemplatePolicy < ApplicationPolicy
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
      scope.joins(award: :organization).where(organization: {id: user.organization.id})
    end

    private

    attr_reader :user, :scope
  end
end
