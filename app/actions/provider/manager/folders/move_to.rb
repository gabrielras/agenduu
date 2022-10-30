# frozen_string_literal: true

module Provider
  module Manager
    module Folders
      class MoveTo < Actor
        input :folder_ids, type: Enumerable
        input :destined_folder, type: Folder

        def call
          folder.update!(archivable: destined_folder)
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
