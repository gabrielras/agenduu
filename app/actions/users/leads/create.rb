# frozen_string_literal: true

module Users
  module Leads
    class Create < Actor
      input :attributes, type: Hash
      input :lead, type: Lead

      def call
        ActiveRecord::Base.transaction do
          self.lead = Lead.new(attributes)
          validate_lead

          lead.save!
        end
      rescue StandardError => e
        fail!(error: e.message)
      end

      private

      def validate_lead
        if attributes[:email].blank? || attributes[:phone_number].blank?
          fail!(error: 'É preciso preencher o email ou o whatsapp')
        end
      end
    end
  end
end
