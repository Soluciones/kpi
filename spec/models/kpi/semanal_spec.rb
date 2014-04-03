# coding: UTF-8

require 'spec_helper'

describe Kpi::Semanal do
  describe ".dame_ultimas_n_semanas" do
    # Del 3 al 10 de marzo era la semana 10

    context "si hoy es lunes" do
      before { Time.stub(now: '2014-03-03 11:25'.to_datetime) }

      it "debe calcular las últimas 5 semanas contando desde la semana pasada hacia atrás" do
        described_class.dame_ultimas_n_semanas(5).should == (5..9)
      end
    end

    context "si hoy es martes" do
      before { Time.stub(now: '2014-03-04 11:25'.to_datetime) }

      it "debe calcular las últimas 5 semanas contando desde la semana actual hacia atrás" do
        described_class.dame_ultimas_n_semanas(5).should == (6..10)
      end
    end
  end
end
