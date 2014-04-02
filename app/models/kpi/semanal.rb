# coding: UTF-8

module Kpi

  CONFIGURACION = {
    'Datos totales de usuarios' => [
      { texto: 'Usuarios Registrados', modelo: 'Usuario', scope: 'todos'},
      { texto: 'Usuarios Activados', modelo: 'Usuario', scope: 'activados'},
      { texto: 'Usuarios sin Activar', modelo: 'Usuario', scope: 'sin_activar'},
      { texto: 'Usuarios Expertos', modelo: 'Tematica::Tematizaciones', scope: 'usuarios_expertos'},
      { texto: 'Suscriptores a la newsletter', modelo: 'Suscripcion', scope: 'todos'}
    ],
    'Aumento de usuarios en la semana' => [
      { texto: 'Usuarios Registrados en la semana', modelo: 'Usuario', scope: 'todos.semanal'},
      { texto: 'Usuarios Activados en la semana', modelo: 'Usuario', scope: 'activados.semanal'},
      { texto: 'Usuarios sin Activar en la semana', modelo: 'Usuario', scope: 'sin_activar.semanal'},
      { texto: 'Usuarios Expertos (nuevos categorizados)', modelo: 'Tematica::Tematizaciones', scope: 'usuarios_expertos.semanal'},
      { texto: 'Suscriptores a la newsletter suscritos en la semana', modelo: 'Suscripcion', scope: 'todos.semanal'}
    ],
    'Autores' => [
      { texto: 'Autores Moderadores', modelo: 'Contenido', scope: 'autores.autor_moderador.semanal'},
      { texto: 'Autores Expertos', modelo: 'Contenido', scope: 'autores.autor_experto.semanal'},
      { texto: 'Autores Normales', modelo: 'Contenido', scope: 'autores.autor_normal.semanal'},
      { texto: 'Autores nuevos que publican primer contenido', modelo: 'Estadistica', scope: 'primera_participacion_del_usuario.semanal'},
      { texto: 'TOTAL AUTORES SEMANALES', modelo: 'Contenido', scope: 'autores.semanal'}
    ],
    'Contenidos totales' => [
      { texto: 'Contenidos publicados por usuarios Moderadores', modelo: 'Contenido', scope: 'autor_moderador.semanal'},
      { texto: 'Contenidos publicados por usuarios Expertos', modelo: 'Contenido', scope: 'autor_experto.semanal'},
      { texto: 'Contenidos publicados por usuarios Normales', modelo: 'Contenido', scope: 'autor_normal.semanal'},
      { texto: 'TOTAL CONTENIDOS SEMANALES', modelo: 'Contenido', scope: 'semanal'}
    ]
  }

  class Semanal < ActiveRecord::Base
    validates :semana, uniqueness: { scope: [:anyo, :modelo, :scope] }
  end
end
