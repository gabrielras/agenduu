# frozen_string_literal: true

module RewardEnum
  class TypesOfReward < EnumerateIt::Base
    associate_values(:main, :exclusive)
  end
end
