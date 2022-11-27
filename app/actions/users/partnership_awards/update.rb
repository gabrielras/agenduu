# frozen_string_literal: true

module Users
  module PartnershipAwards
    class Update < Actor
      input :attributes, type: Hash
      input :award, type: Award

      def call
        ActiveRecord::Base.transaction do
          self.award.update!(attributes)
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
