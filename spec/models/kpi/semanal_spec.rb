# coding: UTF-8

require 'spec_helper'

describe Kpi::Semanal do
  describe ".dame_ultimas_n_semanas" do
    let(:n_semanas) { Random.rand(2..10) }
    let(:semana_actual) { Random.rand(n_semanas..52) }
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

  describe ".calcula_ultima_semana" do
    include Kpi::Clases

    let(:config) { { 'Total usuarios' => [
      { texto: 'Usuarios Activados', modelo: usuario_extern, scopes: [:activados] },
      { texto: 'Usuarios sin Activar', modelo: usuario_extern, scopes: [:sin_activar] }
      ],
      'Aumento de usuarios en la semana' => [
        { texto: 'Usuarios sin Activar en la semana', modelo: usuario_extern, scopes: [:sin_activar, :ultima_semana] }
      ]} }

    before do
      Kpi.stub(configuracion: config)
    end

    it "debe buscar los datos y guardarlos" do
      usuario_class.stub_chain(:activados, :count).and_return(22)
      usuario_class.stub_chain(:sin_activar, :count).and_return(3)
      usuario_class.stub_chain(:sin_activar, :ultima_semana, :count).and_return(2)
      described_class.calcula_ultima_semana
      ultimo_dato_de_usuarios = Kpi::Semanal.where(anyo: Time.now.year, semana: Date.yesterday.cweek, modelo: usuario_extern)
      usuarios_activados = ultimo_dato_de_usuarios.where(scope: [:activados].to_s)
      usuarios_activados.count.should == 1
      usuarios_activados.first.dato == 22
      usuarios_semanales_sin_activar = ultimo_dato_de_usuarios.where(scope: [:sin_activar, :ultima_semana].to_s)
      usuarios_semanales_sin_activar.count.should == 1
      usuarios_semanales_sin_activar.first.dato == 2
    end
  end
end
