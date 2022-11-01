# frozen_string_literal: true

module TaskEnum
  class TypesTasks < EnumerateIt::Base
    associate_values(:activity, :scheduled_activity)
  end
end
