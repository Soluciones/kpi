# coding: UTF-8

module Kpi
  class Semanal < ActiveRecord::Base
    validates :semana, uniqueness: { scope: [:anyo, :modelo, :scope] }
  end
end
