# frozen_string_literal: true

class User::PartnershipPolicy < ApplicationPolicy
  def affiliate?
    true
  end

  def share_with_affiliate?
    true
  end

  def share_with_lead?
    true
  end

  def show?
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
      scope.joins(:organization).where(organization: {id: user.organization.id})
    end

    private

    attr_reader :user, :scope
  end
end
