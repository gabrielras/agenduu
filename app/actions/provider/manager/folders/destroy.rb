# frozen_string_literal: true

module Users
  module Manager
    module Folders
      class Destroy < Actor
        input :folder, type: Folder

        def call
          self.folder.destroy
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
