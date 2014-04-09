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
      'Contenidos en la semana (todos los tipos)' => [
        { texto: 'Contenidos publicados por usuarios Moderadores', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_admin, :ultima_semana] },
        { texto: 'Contenidos publicados por usuarios Expertos', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_experto, :ultima_semana] },
        { texto: 'Contenidos publicados por usuarios Normales', modelo: ::Kpi::Clases.contenido_extern, scopes: [:autor_ni_admin_ni_experto, :ultima_semana] },
        { texto: 'TOTAL CONTENIDOS SEMANALES', modelo: ::Kpi::Clases.contenido_extern, scopes: [:ultima_semana] }
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
end
