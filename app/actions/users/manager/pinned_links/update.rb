# frozen_string_literal: true

module Users
  module Manager
    module PinnedLinks
      class Update < Actor
        input :attributes, type: Hash
        input :pinned_link, type: PinnedLink

        def call
          self.pinned_link.update!(attributes)
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
