# coding: UTF-8

require 'active_support/concern'

module Kpi::Usuario
  include Kpi::Comun
  extend ActiveSupport::Concern

  included do
    extend ComunScopes
    scopes_comunes

    scope :todos, -> { nil }
    scope :activados, -> { where("estado_id > #{ ::Kpi::Personalizacion.estado_usuario_sin_activar }") }
    scope :sin_activar, -> { where(estado_id: ::Kpi::Personalizacion.estado_usuario_sin_activar) }
  end
end
