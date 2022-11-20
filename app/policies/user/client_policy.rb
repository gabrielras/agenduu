# frozen_string_literal: true

class User::CustomerPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def destroy?
    true
  end
end
