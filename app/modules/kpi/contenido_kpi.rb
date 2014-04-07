# coding: UTF-8

require 'active_support/concern'

module Kpi::ContenidoKpi
  include Kpi::Comun
  extend ActiveSupport::Concern

  included do
    extend ComunScopes
    scopes_comunes

    belongs_to :usuario

    scope :autor_moderador, -> { joins(:usuario).where('usuarios.estado_id >= ?', Usuario::ESTADO_USUARIO_ADMIN) }
    scope :autor_no_moderador, -> { where('usuario_id NOT IN (SELECT u.id FROM usuarios u WHERE u.estado_id >= ?)', Usuario::ESTADO_USUARIO_ADMIN) }
  end
end
