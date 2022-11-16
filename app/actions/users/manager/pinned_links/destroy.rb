# frozen_string_literal: true

module Users
  module Manager
    module PinnedLinks
      class Destroy < Actor
        input :pinned_link, type: PinnedLink

        def call
          self.pinned_link.destroy
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
