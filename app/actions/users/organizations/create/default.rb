# frozen_string_literal: true

module User
  module Organizations
    module Create
      class Default < Actor
        input :attributes, type: Hash
        input :owner, type: User
    
        output :organization, type: Organization

        def call
          ActiveRecord::Base.transaction do
            self.organization = Organization.new(attributes)
            organization.save!

            if Role.where(organization: organization, user: owner, role_type: 'owner').present?
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
end
