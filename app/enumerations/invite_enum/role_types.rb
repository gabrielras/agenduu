# frozen_string_literal: true

module InvitationEnum
  class RoleTypes < EnumerateIt::Base
    associate_values(:client, :admin, :employee)
  end
end
