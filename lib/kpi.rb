# coding: UTF-8

require "kpi/engine"

module Kpi
  CLASES = %w(usuario tematizacion suscripcion contenido estadistica)

  def self.configuracion
    usuario = ::Kpi::Clases.usuario_extern
    contenido = ::Kpi::Clases.contenido_extern
    estadistica = ::Kpi::Clases.estadistica_extern
    { 'Datos totales de usuarios' => [
      { texto: 'Usuarios Registrados',
        modelo: usuario,
        scopes: [:todos] },
      { texto: 'Usuarios Activados',
        modelo: usuario,
        scopes: [:activados] },
      { texto: 'Usuarios sin Activar',
        modelo: usuario,
        scopes: [:sin_activar] }
    ],
    'Aumento de usuarios en la semana' => [
      { texto: 'Usuarios Registrados en la semana',
        modelo: usuario,
        scopes: [:todos, :ultima_semana] },
      { texto: 'Usuarios Activados en la semana',
        modelo: usuario,
        scopes: [:activados, :ultima_semana] },
      { texto: 'Usuarios sin Activar en la semana',
        modelo: usuario,
        scopes: [:sin_activar, :ultima_semana] }
    ],
    'Autores' => [
      { texto: 'Autores Moderadores',
        modelo: contenido,
        scopes: [:autores, :autor_admin, :ultima_semana] },
      { texto: 'Autores Expertos',
        modelo: contenido,
        scopes: [:autores, :autor_experto, :ultima_semana] },
      { texto: 'Autores Normales',
        modelo: contenido,
        scopes: [:autores, :autor_ni_admin_ni_experto, :ultima_semana] },
      { texto: 'TOTAL AUTORES SEMANALES',
        modelo: contenido,
        scopes: [:autores, :ultima_semana] },
      { texto: 'Autores nuevos que publican primer contenido',
        modelo: estadistica,
        scopes: [:primera_participacion_del_usuario, :ultima_semana] }
    ],
    'Contenidos en la semana (todos los tipos)' => [
      { texto: 'Contenidos publicados por usuarios Moderadores',
        modelo: contenido,
        scopes: [:autor_admin, :ultima_semana] },
      { texto: 'Contenidos publicados por usuarios Expertos',
        modelo: contenido,
        scopes: [:autor_experto, :ultima_semana] },
      { texto: 'Contenidos publicados por usuarios Normales',
        modelo: contenido,
        scopes: [:autor_ni_admin_ni_experto, :ultima_semana] },
      { texto: 'TOTAL CONTENIDOS SEMANALES',
        modelo: contenido,
        scopes: [:ultima_semana] }
    ],
    'Foros' => [
      { texto: 'Hilos publicados por usuarios Moderadores',
        modelo: contenido,
        scopes: [:autor_admin, :ultima_semana, :hilos] },
      { texto: 'Mensajes publicados por Moderadores',
        modelo: contenido,
        scopes: [:autor_admin, :ultima_semana, :respuestas] },
      { texto: 'TOTAL Contenidos en foros por Moderadores',
        modelo: contenido,
        scopes: [:autor_admin, :ultima_semana, :en_foros] },
      { texto: 'Hilos publicados por Expertos',
        modelo: contenido,
        scopes: [:autor_experto, :ultima_semana, :hilos] },
      { texto: 'Mensajes publicados por Expertos',
        modelo: contenido,
        scopes: [:autor_experto, :ultima_semana, :respuestas] },
      { texto: 'TOTAL Contenidos en foros por Expertos',
        modelo: contenido,
        scopes: [:autor_experto, :ultima_semana, :en_foros] },
      { texto: 'Hilos publicados por Usuarios Normales',
        modelo: contenido,
        scopes: [:autor_ni_admin_ni_experto, :ultima_semana, :hilos] },
      { texto: 'Mensajes publicados por Usuarios Normales',
        modelo: contenido,
        scopes: [:autor_ni_admin_ni_experto, :ultima_semana, :respuestas] },
      { texto: 'TOTAL Contenidos en foros por Usuarios Normales',
        modelo: contenido,
        scopes: [:autor_ni_admin_ni_experto, :ultima_semana, :en_foros] },
      { texto: 'TOTAL CONTENIDOS EN FOROS',
        modelo: contenido,
        scopes: [:ultima_semana, :en_foros] }
    ],
    'Blogs' => [
      { texto: 'Posts publicados por Moderadores',
        modelo: contenido,
        scopes: [:autor_admin, :ultima_semana, :posts] },
      { texto: 'Comentarios de post publicados por Moderadores',
        modelo: contenido,
        scopes: [:autor_admin, :ultima_semana, :comentarios_a_posts] },
      { texto: 'TOTAL CONTENIDOS EN BLOGS',
        modelo: contenido,
        scopes: [:autor_admin, :ultima_semana, :en_blogs] }
    ]
    }
  end

  def self.modelos_y_scopes
    configuracion.values.flatten
  end

  def self.modelos_afectados
    modelos_y_scopes.map{|p| p[:modelo]}.uniq
  end

  module Clases
    CLASES.each do |klass|
      mattr_accessor "#{klass}_extern"

      define_method "#{klass}_class" do
        ::Kpi::Clases.send("#{klass}_extern").constantize
      end
    end
  end

  module Personalizacion
    mattr_accessor :array_foros
    self.array_foros = []
  end
end
