# coding: UTF-8

FactoryGirl.define do
  factory :contenido, class: ::Kpi::Clases.contenido_extern do
    association     :usuario
    subtipo_id      { Random.rand(1..10) }
    publicado       true
    tema            { |c| c.subtipo_id }
    titulo          { Faker::Lorem.sentence }
  end
end
