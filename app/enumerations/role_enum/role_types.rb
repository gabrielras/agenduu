# frozen_string_literal: true

module RoleEnum
  class RoleTypes < EnumerateIt::Base
    associate_values(:owner, :admin, :employee)
  end
end
