# frozen_string_literal: true

module Users
  module Awards
    class Create < Actor
      input :attributes, type: Hash
      input :award, type: Award

      def call
        ActiveRecord::Base.transaction do
          fail!(error: 'Já existe um prêmio cadastrado') if Award.joins(:affiliates).where(organization: attributes[:organization], affiliates: { id: nil }).present?

          self.award = Award.new(attributes)
          award.save!
        end
      rescue StandardError => e
        fail!(error: e.message)
      end
    end
  end
end
