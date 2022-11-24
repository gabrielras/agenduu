# frozen_string_literal: true

module Users
  module Leads
    class Create < Actor
      input :attributes, type: Hash
      input :lead, type: Lead

      def call
        ActiveRecord::Base.transaction do
          self.lead = Lead.new(attributes)
          lead.save!
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
