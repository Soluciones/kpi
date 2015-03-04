# coding: UTF-8

FactoryGirl.define do
  factory :tematizacion, class: ::Kpi::Clases.tematizacion_extern do
    tematizable_type  { FFaker::Lorem.word }
    tematizable_grupo { FFaker::Lorem.word }
    tematica          { Tematica::Tematica.all.to_a.sample }

    factory :tematizacion_usuario_experto do
      tematizable_type  ::Kpi::Clases.usuario_extern
      tematizable_grupo { ::Kpi::Clases.usuario_extern.constantize::EXPERTO }
    end
  end
end
