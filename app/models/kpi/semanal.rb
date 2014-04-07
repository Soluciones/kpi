# coding: UTF-8

module Kpi
  class Semanal < ActiveRecord::Base
    validates :semana, uniqueness: { scope: [:anyo, :modelo, :scope] }

    def self.dame_ultimas_n_semanas(n_semanas)
      semana_mas_antigua = Date.yesterday.cweek - n_semanas + 1
      semana_mas_reciente = Date.yesterday.cweek

      semana_mas_antigua..semana_mas_reciente
    end
  end
end
