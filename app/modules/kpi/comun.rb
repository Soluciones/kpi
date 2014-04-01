# coding: UTF-8

require 'active_support/concern'

module Kpi::Comun
  extend ActiveSupport::Concern

  module ComunScopes
    def scopes_comunes
      scope :ultima_semana, -> { where(created_at: (Date.today - 7.days)..Date.today) }
    end
  end
end
