# coding: UTF-8

module Kpi
  class SemanalController < ApplicationController
    def index
      n_semanas_que_quiero_ver = 5

      @tipo = Kpi::Semanal::TIPOS[params[:tipo]]
      @semanas = Kpi::Semanal.dame_ultimas_n_semanas(n_semanas_que_quiero_ver)
      @kpi_semanales = Kpi::Semanal.where(anyo: Date.yesterday.year, semana: @semanas)
    end
  end
end
