# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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