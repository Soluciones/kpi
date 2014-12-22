require 'spec_helper'

describe Usuario do
  describe "scopes" do
    let!(:activado) { FactoryGirl.create(:usuario, estado_id: 1, created_at: 2.days.ago) }
    let!(:sin_activar) { FactoryGirl.create(:usuario, estado_id: 0, created_at: 2.days.ago) }
    let!(:antiguo) { FactoryGirl.create(:usuario, estado_id: 1, created_at: 2.years.ago) }

    context "en la última semana" do
      it "filtra los activados" do
        nombres = ::Kpi::Clases.usuario_extern.constantize.activados.ultima_semana.map(&:nick)
        expect(nombres).to eq([activado.nick])
      end

      it "filtra los sin_activar" do
        nombres = ::Kpi::Clases.usuario_extern.constantize.sin_activar.ultima_semana.map(&:nick)
        expect(nombres).to eq([sin_activar.nick])
      end

      it "filtra todos" do
        nombres = ::Kpi::Clases.usuario_extern.constantize.todos.ultima_semana.map(&:nick)
        expect(nombres.length).to eq(2)
        expect(nombres).to include(activado.nick)
        expect(nombres).to include(sin_activar.nick)
      end
    end

    context "totales" do
      it "filtra los activados" do
        nombres = ::Kpi::Clases.usuario_extern.constantize.activados.map(&:nick)
        expect(nombres.length).to eq(2)
        expect(nombres).to include(activado.nick)
        expect(nombres).to include(antiguo.nick)
      end

      it "filtra los sin_activar" do
        nombres = ::Kpi::Clases.usuario_extern.constantize.sin_activar.map(&:nick)
        expect(nombres).to include(sin_activar.nick)
      end

      it "filtra todos" do
        expect(::Kpi::Clases.usuario_extern.constantize.todos.count).to eq(3)
      end
    end
  end
end
