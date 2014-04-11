# coding: UTF-8

require "kpi/engine"

module Kpi
  CLASES = %w(usuario tematizacion suscripcion contenido estadistica)

  def self.configuracion
    { 'Datos totales de usuarios' => [
        { texto: 'Usuarios Registrados', modelo: ::Kpi::Clases.usuario_extern, scopes: [:todos] },
        { texto: 'Usuarios Activados', modelo: ::Kpi::Clases.usuario_extern, scopes: [:activados] },
        { texto: 'Usuarios sin Activar', modelo: ::Kpi::Clases.usuario_extern, scopes: [:sin_activar] }
      ],
      'Aumento de usuarios en la semana' => [
        { texto: 'Usuarios Registrados en la semana', modelo: ::Kpi::Clases.usuario_extern, scopes: [:todos, :ultima_semana] },
        { texto: 'Usuarios Activados en la semana', modelo: ::Kpi::Clases.usuario_extern, scopes: [:activados, :ultima_semana] },
        { texto: 'Usuarios sin Activar en la semana', modelo: ::Kpi::Clases.usuario_extern, scopes: [:sin_activar, :ultima_semana] }
      ],
      'Autores' => [
        { texto: 'Autores Moderadores', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autores, :autor_admin, :ultima_semana] },
        { texto: 'Autores Expertos', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autores, :autor_experto, :ultima_semana] },
        { texto: 'Autores Normales', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autores, :autor_ni_admin_ni_experto, :ultima_semana] },
        { texto: 'TOTAL AUTORES SEMANALES', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autores, :ultima_semana] },
        { texto: 'Autores nuevos que publican primer contenido', modelo: ::Kpi::Clases.estadistica_extern, scopes: [:primera_participacion_del_usuario, :ultima_semana] }
      ],
      'Contenidos en la semana (todos los tipos)' => [
        { texto: 'Contenidos publicados por usuarios Moderadores', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_admin, :ultima_semana] },
        { texto: 'Contenidos publicados por usuarios Expertos', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_experto, :ultima_semana] },
        { texto: 'Contenidos publicados por usuarios Normales', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_ni_admin_ni_experto, :ultima_semana] },
        { texto: 'TOTAL CONTENIDOS SEMANALES', modelo: ::Kpi::Clases.contenido_extern, scopes: [:ultima_semana] }
      ],
      'Foros' => [
        { texto: 'Hilos publicados por usuarios Moderadores', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_admin, :ultima_semana, :hilos] },
        { texto: 'Mensajes publicados por Moderadores', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_admin, :ultima_semana, :respuestas] },
        { texto: 'TOTAL Contenidos en foros por Moderadores', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_admin, :ultima_semana, :en_foros] },
        { texto: 'Hilos publicados por Expertos', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_experto, :ultima_semana, :hilos] },
        { texto: 'Mensajes publicados por Expertos', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_experto, :ultima_semana, :respuestas] },
        { texto: 'TOTAL Contenidos en foros por Expertos', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_experto, :ultima_semana, :en_foros] },
        { texto: 'Hilos publicados por Usuarios Normales', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_ni_admin_ni_experto, :ultima_semana, :hilos] },
        { texto: 'Mensajes publicados por Usuarios Normales', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_ni_admin_ni_experto, :ultima_semana, :respuestas] },
        { texto: 'TOTAL Contenidos en foros por Usuarios Normales', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_ni_admin_ni_experto, :ultima_semana, :en_foros] },
        { texto: 'TOTAL CONTENIDOS EN FOROS', modelo: ::Kpi::Clases.contenido_extern, scopes: [:ultima_semana, :en_foros] }
      ],
      'Blogs' => [
        { texto: 'Posts publicados por Moderadores', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_admin, :ultima_semana, :posts] },
        { texto: 'Comentarios de post publicados por Moderadores', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_admin, :ultima_semana, :comentarios_a_posts] },
        { texto: 'TOTAL CONTENIDOS EN BLOGS', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_admin, :ultima_semana, :en_blogs] }
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
