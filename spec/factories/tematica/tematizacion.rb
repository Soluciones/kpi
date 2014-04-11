# coding: UTF-8

FactoryGirl.define do
  factory :tematizacion, class: ::Kpi::Clases.tematizacion_extern do
    tematizable_type  { Faker::Lorem.word }
    tematizable_grupo { Faker::Lorem.word }
    tematica_id       { Random.rand(1..10) }

    factory :tematizacion_usuario_experto do
      tematizable_type  ::Kpi::Clases.usuario_extern
      tematizable_grupo { ::Kpi::Clases.usuario_extern.constantize::EXPERTO }
    end
  end
end
