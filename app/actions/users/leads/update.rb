# frozen_string_literal: true

module Users
  module Leads
    class Update < Actor
      input :attributes, type: Hash
      input :lead, type: Lead

      def call
        ActiveRecord::Base.transaction do
          self.lead.update!(attributes)
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
