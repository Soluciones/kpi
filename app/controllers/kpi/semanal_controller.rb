# coding: UTF-8

module Kpi
  class SemanalController < ApplicationController
    def index
      n_semanas_que_quiero_ver = 5
      semana_mas_antigua_que_quiero_ver = Date.yesterday.cweek - n_semanas_que_quiero_ver + 1
      semana_mas_reciente_que_quiero_ver = Date.yesterday.cweek
      @semanas = semana_mas_antigua_que_quiero_ver..semana_mas_reciente_que_quiero_ver
      @kpi_semanales = Kpi::Semanal.where(anyo: Date.yesterday.year, semana: @semanas)
    end
  end
end
