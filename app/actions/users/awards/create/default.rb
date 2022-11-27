# frozen_string_literal: true

module Users
  module Awards
    module Create
      class Default < Actor
        input :attributes, type: Hash

        output :award, type: Award

        def call
          self.award = Award.new(attributes)
          fail!(error: 'Já existe um prêmio principal cadastrado') if Award.where(type_of_award: 'main', organization: attributes[:organization]).present?

          award.save!
        end
      end
    end
  end
end
