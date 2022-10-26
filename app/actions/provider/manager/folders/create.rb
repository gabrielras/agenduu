# frozen_string_literal: true

module Users
  module Manager
    module Folders
      class Create < Actor
        input :attributes, type: Hash

        output :folder, type: Folder

        def call
          ActiveRecord::Base.transaction do
            self.folder = Folder.new(attributes)
            folder.save!
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
