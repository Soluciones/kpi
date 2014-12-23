require 'spec_helper'

describe Usuario do
  describe "scopes" do
    let!(:activado) { FactoryGirl.create(:usuario, estado_id: 1, created_at: 2.days.ago) }
    let!(:sin_activar) { FactoryGirl.create(:usuario, estado_id: 0, created_at: 2.days.ago) }
    let!(:antiguo) { FactoryGirl.create(:usuario, estado_id: 1, created_at: 2.years.ago) }
    let(:usuario_class) { ::Kpi::Clases.usuario_extern.constantize }

    context "en la última semana" do
      it "filtra los activados" do
        nombres = usuario_class.activados.ultima_semana.pluck(:nick)
        expect(nombres).to eq([activado.nick])
      end

      it "filtra los sin_activar" do
        nombres = usuario_class.sin_activar.ultima_semana.pluck(:nick)
        expect(nombres).to eq([sin_activar.nick])
      end

      it "filtra todos" do
        nombres = usuario_class.todos.ultima_semana.pluck(:nick)
        expect(nombres.length).to eq(2)
        expect(nombres).to include(activado.nick)
        expect(nombres).to include(sin_activar.nick)
      end
    end

    context "totales" do
      it "filtra los activados" do
        nombres = usuario_class.activados.pluck(:nick)
        expect(nombres.length).to eq(2)
        expect(nombres).to include(activado.nick)
        expect(nombres).to include(antiguo.nick)
      end

      it "filtra los sin_activar" do
        nombres = usuario_class.sin_activar.pluck(:nick)
        expect(nombres).to include(sin_activar.nick)
      end

      it "filtra todos" do
        expect(usuario_class.todos.count).to eq(3)
      end
    end
  end
end
