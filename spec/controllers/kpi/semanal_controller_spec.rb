require 'spec_helper'

module Kpi
  describe SemanalController, type: :controller do
    describe '#index' do
      before { FactoryGirl.create(:semanal, anyo: Time.now.year, semana: Date.today.cweek - 1) }

      it 'debe funcionar sin errores' do
        get :index, { use_route: :kpi }
        expect(response.status).to eq(200)
      end
    end
  end
end
