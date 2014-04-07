# coding: UTF-8

FactoryGirl.define do
  factory :usuario, class: 'Usuario' do
    nick              { "#{ Faker::Name.first_name }_#{ Faker::Lorem.word }_#{ rand(9000) }" }
    estado_id         { Usuario::ESTADO_USUARIO_SIN_ACTIVAR }
  end
end
