# frozen_string_literal: true

module AwardEnum
  class TypeOfAwards < EnumerateIt::Base
    associate_values(:main, :partnership)
  end
end
