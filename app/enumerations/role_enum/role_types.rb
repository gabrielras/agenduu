# frozen_string_literal: true

module RoleEnum
  class RoleTypes < EnumerateIt::Base
    associate_values(:customer, :owner, :admin, :employee)
  end
end
