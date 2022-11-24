# frozen_string_literal: true

module Users
  module Organizations
    class Update < Actor
      input :attributes, type: Hash
      input :organization, type: Organization

      def call
        self.organization.update!(attributes)
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
