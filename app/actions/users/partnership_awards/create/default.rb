# frozen_string_literal: true

module Users
  module PartnershipAwards
    module Create
      class Default < Actor
        input :attributes, type: Hash

        output :award, type: Award

        def call
          self.award = Award.new(attributes)
          fail!(error: 'Já existe um prêmio cadastrado') if Award.joins(:affiliates).where(organization: attributes[:organization], affiliates: { id: nil }).present?

          award.save!
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
