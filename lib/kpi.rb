require "kpi/engine"

module Kpi
  USUARIO = 'Usuario'
  EXPERTOS = 'Tematica::Tematizacion'
  SUSCRIPCION = 'Suscripcion'
  CONTENIDO = 'Contenido'
  ESTADISTICA = 'Estadistica'

  CONFIGURACION = {
    'Datos totales de usuarios' => [
      { texto: 'Usuarios Registrados', modelo: USUARIO, scope: 'todos'},
      { texto: 'Usuarios Activados', modelo: USUARIO, scope: 'activados'},
      { texto: 'Usuarios sin Activar', modelo: USUARIO, scope: 'sin_activar'},
      { texto: 'Usuarios Expertos', modelo: EXPERTOS, scope: 'usuarios_expertos'},
      { texto: 'Suscriptores a la newsletter', modelo: SUSCRIPCION, scope: 'todos'}
    ],
    'Aumento de usuarios en la semana' => [
      { texto: 'Usuarios Registrados en la semana', modelo: USUARIO, scope: 'todos.semanal'},
      { texto: 'Usuarios Activados en la semana', modelo: USUARIO, scope: 'activados.semanal'},
      { texto: 'Usuarios sin Activar en la semana', modelo: USUARIO, scope: 'sin_activar.semanal'},
      { texto: 'Usuarios Expertos (nuevos categorizados)', modelo: EXPERTOS, scope: 'usuarios_expertos.semanal'},
      { texto: 'Suscriptores a la newsletter suscritos en la semana', modelo: SUSCRIPCION, scope: 'todos.semanal'}
    ],
    'Autores' => [
      { texto: 'Autores Moderadores', modelo: CONTENIDO, scope: 'autores.autor_moderador.semanal'},
      { texto: 'Autores Expertos', modelo: CONTENIDO, scope: 'autores.autor_experto.semanal'},
      { texto: 'Autores Normales', modelo: CONTENIDO, scope: 'autores.autor_normal.semanal'},
      { texto: 'Autores nuevos que publican primer contenido', modelo: ESTADISTICA, scope: 'primera_participacion_del_usuario.semanal'},
      { texto: 'TOTAL AUTORES SEMANALES', modelo: CONTENIDO, scope: 'autores.semanal'}
    ],
    'Contenidos totales' => [
      { texto: 'Contenidos publicados por usuarios Moderadores', modelo: CONTENIDO, scope: 'autor_moderador.semanal'},
      { texto: 'Contenidos publicados por usuarios Expertos', modelo: CONTENIDO, scope: 'autor_experto.semanal'},
      { texto: 'Contenidos publicados por usuarios Normales', modelo: CONTENIDO, scope: 'autor_normal.semanal'},
      { texto: 'TOTAL CONTENIDOS SEMANALES', modelo: CONTENIDO, scope: 'semanal'}
    ]
  }
end
