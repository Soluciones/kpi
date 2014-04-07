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
    ],
    'Contenidos en la semana (todos los tipos)' => [
      { texto: 'Contenidos publicados por usuarios Moderadores', modelo: CONTENIDO, scope: [:autor_moderador, :ultima_semana] },
      { texto: 'Contenidos publicados por usuarios Expertos', modelo: CONTENIDO, scope: [:autor_experto, :ultima_semana] }
    ]
  }

  MODELOS_Y_SCOPES = CONFIGURACION.values.flatten
  MODELOS_AFECTADOS = MODELOS_Y_SCOPES.map{|p| p[:modelo]}.uniq
end
