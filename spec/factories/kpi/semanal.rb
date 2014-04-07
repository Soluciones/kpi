# coding: UTF-8

FactoryGirl.define do
  factory :semanal, class: 'Kpi::Semanal' do
    anyo              { Random.rand(2010..2020) }
    semana            { Random.rand(1..53) }
    modelo            { Faker::Lorem.word }
    scope             { Faker::Lorem.word }
    dato              { Random.rand(0..500) }
  end
end
