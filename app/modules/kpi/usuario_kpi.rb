# coding: UTF-8

require 'active_support/concern'

module Kpi::UsuarioKpi
  include Kpi::Comun
  extend ActiveSupport::Concern

  included do
    extend ComunScopes
    scopes_comunes

    ESTADO_USUARIO_SIN_ACTIVAR = 0
    ESTADO_USUARIO_NORMAL = 1
    ESTADO_USUARIO_ADMIN = 3
    EXPERTO = 'Experto'

    scope :todos, -> { nil }
    scope :activados, -> { where("estado_id > #{ ESTADO_USUARIO_SIN_ACTIVAR }") }
    scope :sin_activar, -> { where(estado_id: ESTADO_USUARIO_SIN_ACTIVAR) }

    def self.ids_de_expertos
      ::Kpi::Clases.tematizacion_extern.constantize.where(tematizable_type: ::Kpi::Clases.usuario_extern, tematizable_grupo: EXPERTO).pluck(:tematizable_id)
    end

    def self.ids_de_admins
      self.where('estado_id >= ?', ESTADO_USUARIO_ADMIN).pluck(:id)
    end
  end
end
