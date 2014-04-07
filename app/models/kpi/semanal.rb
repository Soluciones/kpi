# coding: UTF-8

module Kpi
  class Semanal < ActiveRecord::Base
    validates :semana, uniqueness: { scope: [:anyo, :modelo, :scope] }

    def self.dame_ultimas_n_semanas(n_semanas)
      semana_mas_antigua = Date.yesterday.cweek - n_semanas + 1
      semana_mas_reciente = Date.yesterday.cweek

      semana_mas_antigua..semana_mas_reciente
    end

    # Kpi::Semanal.calcula_ultima_semana
    def self.calcula_ultima_semana
      ultima_semana = Date.yesterday.cweek
      self.where(anyo: Date.yesterday.year, semana: ultima_semana).delete_all
      modelos_y_scopes = Kpi::CONFIGURACION.values.flatten
      modelos_y_scopes.each do |modelo_y_scope|
        dato = eval("#{ modelo_y_scope[:modelo] }.#{ modelo_y_scope[:scope] }.count")
        self.create(anyo: Date.yesterday.year, semana: ultima_semana, modelo: modelo_y_scope[:modelo], scope: modelo_y_scope[:scope], dato: dato)
      end
    end
  end
end
