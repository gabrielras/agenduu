# frozen_string_literal: true

module InvitationEnum
  class States < EnumerateIt::Base
    associate_values(:accepted, :rejected, :pending)
  end
end
