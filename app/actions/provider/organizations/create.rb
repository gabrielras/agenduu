# frozen_string_literal: true

module Provider
  module Organizations
    class Create < Actor
      input :attributes, type: Hash
      input :owner, type: User
  
      output :provider, type: Organization

      def call
        ActiveRecord::Base.transaction do
          self.provider = Organization.new(attributes)
          provider.save!

          if Role.where(organization: provider, user: owner, role_type: 'owner').present?
            fail!(error: 'Seu e-mail já tem cadastro como proprietário em uma empresa.')
          end
          Role.create!(role_type: 'owner', user: owner, organization: provider)
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end