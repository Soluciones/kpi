# coding: UTF-8

FactoryGirl.define do
  factory :contenido, class: ::Kpi::Clases.contenido_extern do
    association     :usuario
    subtipo_id      { Random.rand(1..10) }
    publicado       true
    tema            { |c| c.subtipo_id }
    titulo          { FFaker::Lorem.sentence }

    trait :mensaje_inicial do
      after(:create) do |hilo, evaluator|
        hilo.update_attribute('inicial_id', hilo.id)
      end
    end

    factory :hilo, traits: [:mensaje_inicial] do
      subtipo_id      { ::Kpi::Personalizacion.array_foros.sample }
    end

    factory :respuesta_con_hilo do
      before(:create) do |respuesta, evaluator|
        hilo = FactoryGirl.create(:hilo, created_at: respuesta.created_at - 5.minutes, usuario: respuesta.usuario)
        respuesta.inicial_id = hilo.id
        respuesta.subtipo_id = hilo.subtipo_id
      end
    end

    factory :post, traits: [:mensaje_inicial] do
      blog_id         { Random.rand(1..200) }
      subtipo_id      { ::Kpi::Personalizacion.array_foros.max + 1 }  # No debe ser un subtipo de foro, por lo demás da igual
    end

    factory :comentario_con_post do
      subtipo_id      { ::Kpi::Personalizacion.array_foros.max + 2 }  # No debe ser un subtipo de foro, por lo demás da igual

      before(:create) do |comentario, evaluator|
        post = FactoryGirl.create(:post, created_at: comentario.created_at - 5.minutes, usuario: comentario.usuario)
        comentario.inicial_id = post.id
        comentario.blog_id = post.blog_id
      end
    end
  end
end
