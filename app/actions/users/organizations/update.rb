# frozen_string_literal: true

module Users
  module Organizations
    class Update < Actor
      input :attributes, type: Hash
      input :provider, type: Organization

      def call
        self.provider.update!(attributes)
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
