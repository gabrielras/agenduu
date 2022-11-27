# frozen_string_literal: true

class User::DashboardPolicy < ApplicationPolicy
  def index?
    true
  end
end
