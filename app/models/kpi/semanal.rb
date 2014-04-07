# coding: UTF-8

module Kpi
  class Semanal < ActiveRecord::Base
    validates :semana, uniqueness: { scope: [:anyo, :modelo, :scope] }

    def self.dame_ultimas_n_semanas(n_semanas)
      semana_mas_antigua = dia_de_referencia.cweek - n_semanas + 1
      semana_mas_reciente = dia_de_referencia.cweek

      semana_mas_antigua..semana_mas_reciente
    end

    def self.calcula_ultima_semana
      ultima_semana = dia_de_referencia.cweek
      self.where(anyo: dia_de_referencia.year, semana: ultima_semana).delete_all
      Kpi::MODELOS_Y_SCOPES.each do |modelo_y_scope|
        dato = encadena_modelo_y_scopes(modelo_y_scope).count
        self.create(anyo: dia_de_referencia.year, semana: ultima_semana, modelo: modelo_y_scope[:modelo], scope: modelo_y_scope[:scopes].to_s, dato: dato)
      end
    end

    def self.encadena_modelo_y_scopes(modelo_y_scope)
      q = modelo_y_scope[:modelo].constantize
      modelo_y_scope[:scopes].each { |scope| q = q.send(scope) }
      q
    end

    def dia_de_referencia
      Date.yesterday
    end
  end
end
