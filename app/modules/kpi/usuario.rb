# coding: UTF-8

require 'active_support/concern'

module Kpi::Usuario
  include Kpi::Comun
  extend ActiveSupport::Concern

  included do
    extend ComunScopes
    scopes_comunes

    ESTADO_USUARIO_SIN_ACTIVAR = 0

    scope :todos, -> { nil }
    scope :activados, -> { where("estado_id > #{ ESTADO_USUARIO_SIN_ACTIVAR }") }
    scope :sin_activar, -> { where(estado_id: ESTADO_USUARIO_SIN_ACTIVAR) }
  end
end
