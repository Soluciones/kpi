# coding: UTF-8

FactoryGirl.define do
  factory :usuario, class: ::Kpi::Clases.usuario_extern do
    nick              { "#{ Faker::Name.first_name }_#{ Faker::Lorem.word }_#{ rand(9000) }" }
    estado_id         { ::Kpi::Clases.usuario_extern.constantize::ESTADO_USUARIO_SIN_ACTIVAR }

    factory :usuario_admin do
      estado_id         { ::Kpi::Clases.usuario_extern.constantize::ESTADO_USUARIO_ADMIN }
    end

    factory :usuario_experto do
      estado_id         { ::Kpi::Clases.usuario_extern.constantize::ESTADO_USUARIO_NORMAL }

      after(:create) do |usuario, evaluator|
        FactoryGirl.create(:tematizacion_usuario_experto, tematizable_id: usuario.id)
      end
    end

    factory :usuario_normal do
      estado_id         { ::Kpi::Clases.usuario_extern.constantize::ESTADO_USUARIO_NORMAL }
    end
  end
end
