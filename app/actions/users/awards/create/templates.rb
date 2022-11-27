# frozen_string_literal: true

module Users
  module Awards
    module Create
      class Templates < Actor 
        input :award, type: Award

        def call
          ActiveRecord::Base.transaction do
            ModalAwardTemplate.create!(
              award: award,
              title: 'asdsad',
              description: 'asdasdasd',
              text_submit: 'Gerar Código',
              primary_color: 'dark',
              secondary_color: 'dark'
        
            )
            PageAwardTemplate.create!(
              award: award,
              title: 'asdsad',
              description: 'asdasdasd',
              text_submit: 'Gerar Código',
              primary_color: 'dark',
              secondary_color: 'dark'
            )
            RewardTemplate.create!(
              award: award,
              title: 'asdsad',
              description: 'asdasdasd',
              text_submit: 'Gerar Código',
              primary_color: 'dark',
              secondary_color: 'dark'
            )
          end
        end
      end
    end
  end
end
