# coding: UTF-8

require 'spec_helper'

module Kpi
  describe SemanalController do
    describe "#index" do
      before { FactoryGirl.create(:semanal, anyo: Time.now.year, semana: Date.today.cweek - 1) }

      it "debe funcionar sin errores" do
        get :index, { use_route: :kpi }
        response.should be_ok
      end
    end
  end
end
