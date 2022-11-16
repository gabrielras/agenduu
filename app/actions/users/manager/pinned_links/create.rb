# frozen_string_literal: true

module Users
  module Manager
    module PinnedLinks
      class Create < Actor
        input :attributes, type: Hash

        output :pinned_link, type: PinnedLink

        def call
          ActiveRecord::Base.transaction do
            self.pinned_link = PinnedLink.new(attributes)
            pinned_link.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
