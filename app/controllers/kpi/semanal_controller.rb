# coding: UTF-8

module Kpi
  class SemanalController < ApplicationController
    def index
      @semanas = (Date.yesterday.cweek - 4)..Date.yesterday.cweek
      @kpi_semanales = Kpi::Semanal.where(anyo: Date.yesterday.year, semana: @semanas)
    end
  end
end
