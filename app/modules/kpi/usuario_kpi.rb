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
      Rails.cache.fetch "ids_de_expertos" do
        ActiveRecord::Base.connection.select_values("SELECT tt.tematizable_id
                                                       FROM tematica_tematizaciones tt
                                                      WHERE tt.tematizable_type = 'Usuario' and tt.tematizable_grupo = '#{EXPERTO}'")
      end
    end
  end
end
