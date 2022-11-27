# frozen_string_literal: true

module Users
  module Leads
    class Update < Actor
      input :attributes, type: Hash
      input :lead, type: Lead

      def call
        ActiveRecord::Base.transaction do
          validate_lead

          self.lead.update!(attributes)
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
