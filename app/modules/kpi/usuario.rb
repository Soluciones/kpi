# coding: UTF-8

require 'active_support/concern'

module Kpi::Usuario
  include Kpi::Comun
  extend ActiveSupport::Concern

  included do
    extend ComunScopes
    scopes_comunes
  end

  module UsuariosScopes
    def scopes_usuario
      scope :todos, -> { nil }
      scope :activados, -> { where("estado_id > 0") }
      scope :sin_activar, -> { where(estado_id: 0) }
    end
  end
end
