# coding: UTF-8

module Kpi
  class SemanalController < ApplicationController
    def index
      cuantas_semanas_quiero_ver = 5
      @semanas = (Date.yesterday.cweek - cuantas_semanas_quiero_ver + 1)..Date.yesterday.cweek
      @kpi_semanales = Kpi::Semanal.where(anyo: Date.yesterday.year, semana: @semanas)
    end
  end
end
