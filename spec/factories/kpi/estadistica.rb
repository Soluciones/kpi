# coding: UTF-8

FactoryGirl.define do
  factory :estadistica, class: ::Kpi::Clases.estadistica_extern do
    association     :usuario
    subtipo_id      { Random.rand(1..10) }
  end
end
