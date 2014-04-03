# coding: UTF-8

require 'spec_helper'

module Kpi
  describe SemanalController do
    describe "#index" do

      describe "debe calcular las últimas 5 semanas contando desde ayer" do
        # Del 3 al 10 de marzo era la semana 10

        it "si hoy es lunes, empieza por la semana pasada hacia atrás" do
          Time.stub(now: '2014-03-03 11:25'.to_datetime)
          get :index, { use_route: :kpi }
          assigns(:semanas).should == (5..9)
        end

        it "si hoy es martes, empieza por la semana actual hacia atrás" do
          Time.stub(now: '2014-03-04 11:25'.to_datetime)
          get :index, { use_route: :kpi }
          assigns(:semanas).should == (6..10)
        end
      end

      describe "debe devolver los KPI que tocan" do
        let!(:dato_semanal_nuevo) { Semanal.create(anyo: 2014, semana: 10)}
        let!(:dato_semanal_antiguo_pero_en_rango) { Semanal.create(anyo: 2014, semana: 6)}
        let!(:dato_semanal_demasiado_antiguo) { Semanal.create(anyo: 2014, semana: 5)}
        let!(:dato_semanal_del_anyo_pasado) { Semanal.create(anyo: 2013, semana: 10)}

        it "devuelve los de las últimas 5 semanas" do
          Time.stub(now: '2014-03-04 11:25'.to_datetime)
          get :index, { use_route: :kpi }
          ids = assigns(:kpi_semanales).map(&:id)
          ids.length.should == 2
          ids.should include(dato_semanal_antiguo_pero_en_rango.id, dato_semanal_nuevo.id)
        end
      end
    end
  end
end
