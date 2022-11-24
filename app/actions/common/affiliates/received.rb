# frozen_string_literal: true

module Common
  module Affiliates
    class Create < Actor
      input :organization_id, type: String
      input :attributes, type: Hash

      input :link, type: String

      def call
        ActiveRecord::Base.transaction do
          affiliate = Affiliate.new(attributes.merge(organization_id: organization_id))
          affiliate.save!

          self.link = generate_link
        end
      end

      private

      def generate_link

      end
    end
  end
end
