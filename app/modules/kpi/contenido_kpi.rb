# coding: UTF-8

require 'active_support/concern'

module Kpi::ContenidoKpi
  include Kpi::Comun
  extend ActiveSupport::Concern

  included do
    extend ComunScopes
    scopes_comunes

    belongs_to :usuario, class_name: ::Kpi::Clases.usuario_extern

    scope :autores, -> { select('DISTINCT usuario_id') }
    scope :autor_admin, -> { where(usuario_id: ::Kpi::Clases.usuario_extern.constantize.ids_de_admins) }
    scope :autor_no_admin, -> { where('usuario_id NOT IN (?)', ::Kpi::Clases.usuario_extern.constantize.ids_de_admins) }
    scope :autor_experto, -> { autor_no_admin.where(usuario_id: ::Kpi::Clases.usuario_extern.constantize.ids_de_expertos) }
    scope :autor_ni_admin_ni_experto, -> { autor_no_admin.where("usuario_id NOT IN (?)", ::Kpi::Clases.usuario_extern.constantize.ids_de_expertos) }

    scope :mensaje_inicial, -> { where('inicial_id = id') }
    scope :contestando, -> { where('inicial_id <> id') }
    scope :en_foros, -> { where(subtipo_id: ::Kpi::Personalizacion.array_foros) }
    scope :hilos, -> { en_foros.mensaje_inicial }
    scope :respuestas, -> { en_foros.contestando }
    scope :en_blogs, -> { where('blog_id IS NOT NULL') }
    scope :posts, -> { en_blogs.mensaje_inicial }
    scope :comentarios_a_posts, -> { en_blogs.contestando }
  end
end
