# coding: UTF-8

class Usuario < ActiveRecord::Base
  include Kpi::Usuario
  extend UsuariosScopes
  scopes_usuario
end
