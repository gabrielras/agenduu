# frozen_string_literal: true

module AccessibilityEnum
  class Allows < EnumerateIt::Base
    associate_values(:interact, :manager)
  end
end
