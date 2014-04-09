# coding: UTF-8

FactoryGirl.define do
  factory :usuario, class: ::Kpi::Clases.usuario_extern do
    nick              { "#{ Faker::Name.first_name }_#{ Faker::Lorem.word }_#{ rand(9000) }" }
    estado_id         { ::Kpi::Clases.usuario_extern.constantize::ESTADO_USUARIO_SIN_ACTIVAR }
  end
end
