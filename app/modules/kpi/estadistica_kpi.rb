require 'active_support/concern'

module Kpi::EstadisticaKpi
  include Kpi::Comun
  extend ActiveSupport::Concern

  included do
    extend ComunScopes
    scopes_comunes

    belongs_to :usuario, class_name: ::Kpi::Clases.usuario_extern

    scope :ultima_semana, -> { having('MIN(created_at) BETWEEN ? AND ?', 1.week.ago, Time.current) }
    scope :primera_participacion_del_usuario, -> { select('usuario_id, MIN(created_at) AS fecha_primera_participacion').group(:usuario_id) }
  end
end
