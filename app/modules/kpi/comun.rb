# coding: UTF-8

require 'active_support/concern'

module Kpi::Comun
  extend ActiveSupport::Concern

  module ComunScopes
    def scopes_comunes
      scope :ultima_semana, -> { where(created_at: 7.days.ago.to_date..Time.now.to_date) }
    end
  end
end
