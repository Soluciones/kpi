# coding: UTF-8

require 'spec_helper'

describe Kpi::Semanal do
  describe ".dame_ultimas_n_semanas" do
    let(:n_semanas) { Random.rand(2..10) }
    let(:semana_actual) { Random.rand(n_semanas..53) }
    let(:semana_pasada) { semana_actual - 1 }
    let(:lunes) { Date.commercial(Time.now.year, semana_actual, 1).to_datetime }
    let(:martes) { lunes + 1.day }

    context "si hoy es lunes" do
      before { Time.stub(now: lunes) }

      it "debe calcular las últimas n semanas contando desde la semana pasada hacia atrás" do
        resultado = described_class.dame_ultimas_n_semanas(n_semanas)
        resultado.max.should == semana_pasada
        resultado.should have(n_semanas).semanas
      end
    end

    context "si hoy es martes" do
      before { Time.stub(now: martes) }

      it "debe calcular las últimas n semanas contando desde la semana actual hacia atrás" do
        resultado = described_class.dame_ultimas_n_semanas(n_semanas)
        resultado.max.should == semana_actual
        resultado.should have(n_semanas).semanas
      end
    end
  end
end
