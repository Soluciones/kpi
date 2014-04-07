require "kpi/engine"

module Kpi
  USUARIO = 'Usuario'
  EXPERTOS = 'Tematica::Tematizacion'
  SUSCRIPCION = 'Suscripcion'
  CONTENIDO = 'Contenido'
  ESTADISTICA = 'Estadistica'

  CONFIGURACION = {
    'Datos totales de usuarios' => [
      { texto: 'Usuarios Registrados', modelo: USUARIO, scopes: [:todos] },
      { texto: 'Usuarios Activados', modelo: USUARIO, scopes: [:activados] },
      { texto: 'Usuarios sin Activar', modelo: USUARIO, scopes: [:sin_activar] }
    ],
    'Aumento de usuarios en la semana' => [
      { texto: 'Usuarios Registrados en la semana', modelo: USUARIO, scopes: [:todos, :ultima_semana] },
      { texto: 'Usuarios Activados en la semana', modelo: USUARIO, scopes: [:activados, :ultima_semana] },
      { texto: 'Usuarios sin Activar en la semana', modelo: USUARIO, scopes: [:sin_activar, :ultima_semana] }
    ]
  }

  MODELOS_AFECTADOS = CONFIGURACION.values.flatten.map{|p| p[:modelo]}.uniq
end
