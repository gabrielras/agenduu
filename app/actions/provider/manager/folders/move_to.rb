# frozen_string_literal: true

module Provider
  module Manager
    module Folders
      class MoveTo < Actor
        input :folder_id, type: String
        input :destined_folder_id, type: String

        def call
          Folder.find(folder_id).update!(foldable: Folder.find(destined_folder_id))
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
