require 'spec_helper'

module Kpi
  describe SemanalController, type: :controller do
    before do
      @routes = Kpi::Engine.routes
    end

    describe '#index' do
      before { FactoryGirl.create(:semanal, anyo: Time.now.year, semana: Date.today.cweek - 1) }

      it 'debe funcionar sin errores' do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end
end
