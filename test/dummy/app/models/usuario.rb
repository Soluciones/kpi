# coding: UTF-8

class Usuario < ActiveRecord::Base
  include Kpi::UsuarioKpi
end
