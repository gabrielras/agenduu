# frozen_string_literal: true

module RoleEnum
  class RoleTypes < EnumerateIt::Base
    associate_values(:customer, :owner, :admin, :manager, :employee)
  end
end
