# coding: UTF-8

FactoryGirl.define do
  factory :tematizacion, class: Tematica::Tematizacion do
    tematizable_type  { Faker::Lorem.word }
    tematizable_grupo { Faker::Lorem.word }
    tematica_id       { Random.rand(1..10) }

    factory :tematizacion_usuario_experto do
      tematizable_type  'Usuario'
      tematizable_grupo { Usuario::EXPERTO }
    end
  end
end
