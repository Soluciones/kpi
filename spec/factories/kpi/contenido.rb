# coding: UTF-8

FactoryGirl.define do
  factory :contenido, class: 'Contenido' do
    association     :usuario
    subtipo_id      { (1..10).to_a.sample }
    publicado       true
    tema            { |c| c.subtipo_id }
    titulo          { Faker::Lorem.sentence }
  end
end
