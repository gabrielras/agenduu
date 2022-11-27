# frozen_string_literal: true

module Users
  module PartnershipAwards
    class Destroy < Actor
      input :attributes, type: Hash
      input :award, type: Award

      def call
        ActiveRecord::Base.transaction do
          self.award.destroy
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
