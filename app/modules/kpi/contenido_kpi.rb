# coding: UTF-8

require 'active_support/concern'

module Kpi::ContenidoKpi
  include Kpi::Comun
  extend ActiveSupport::Concern

  included do
    extend ComunScopes
    scopes_comunes

    belongs_to :usuario

    scope :autor_admin, -> { where(usuario_id: Usuario.ids_de_admins) }
    scope :autor_no_admin, -> { where('usuario_id NOT IN (?)', Usuario.ids_de_admins) }
    scope :autor_experto, -> { autor_no_admin.where(usuario_id: Usuario.ids_de_expertos) }
    scope :autor_ni_admin_ni_experto, -> { autor_no_admin.where("usuario_id NOT IN (?)", Usuario.ids_de_expertos) }
  end
end
