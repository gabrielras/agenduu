# frozen_string_literal: true

module Users
  module Organizations
    module Create
      class Received < Actor
        play Default, Invites
      end
    end
  end
end
