# frozen_string_literal: true

module Users
  module Organizations
    module Create
      class RatingQuestions < Actor 
        input :organization, type: Organization

        def call
          ActiveRecord::Base.transaction do
            ['Excelente Comunicação', 'Alta Qualidade', 'Entrega Ráṕida'].each do |phrase|
              RatingQuestion.create!(title: phrase, value: 5)
            end
            ['Boa Comunicação', 'Boa Qualidade', 'Entrega no Prazo'].each do |phrase|
              RatingQuestion.create!(title: phrase, value: 4)
            end
            ['Comunicação Normal', 'Qualidade Normal', 'Pequeno Atraso'].each do |phrase|
              RatingQuestion.create!(title: phrase, value: 3)
            end
            ['Comunicação Ruim', 'Qualidade Inferior', 'Atrasado'].each do |phrase|
              RatingQuestion.create!(title: phrase, value: 2)
            end
            ['Péssima Comunicação', 'Qualidade Ruim', 'Muito Atrasado'].each do |phrase|
              RatingQuestion.create!(title: phrase, value: 1)
            end
          end
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
