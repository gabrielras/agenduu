# frozen_string_literal: true

module TaskEnum
  class TypesTask < EnumerateIt::Base
    associate_values(:activity, :scheduled_activity)
  end
end
