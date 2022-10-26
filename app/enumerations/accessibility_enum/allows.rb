# frozen_string_literal: true

module AccessibilityEnum
  class Allows < EnumerateIt::Base
    associate_values(:to_view, :interact, :manager)
  end
end
