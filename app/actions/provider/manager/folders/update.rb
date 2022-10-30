# frozen_string_literal: true

module Provider
  module Manager
    module Folders
      class Update < Actor
        input :attributes, type: Hash
        input :folder, type: Folder

        def call
          self.folder.update!(attributes)
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
