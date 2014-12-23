require 'spec_helper'

describe 'Estadistica' do
  describe 'scope "primera_participacion_del_usuario"' do
    let(:id_usuario_nuevo) { Random.rand(1000..5000) }
    let(:id_usuario_antiguo) { Random.rand(100..500) }

    before do
      FactoryGirl.create(:estadistica, usuario_id: id_usuario_nuevo, created_at: 1.day.ago)
      FactoryGirl.create(:estadistica, usuario_id: id_usuario_antiguo, created_at: 1.day.ago, subtipo_id: Random.rand(1..5))
      FactoryGirl.create(:estadistica, usuario_id: id_usuario_antiguo, created_at: 1.year.ago, subtipo_id: Random.rand(6..10))
    end

    it 'debe identificar como nuevo al que tiene estadísticas recientes y no tiene estadísticas antiguas' do
      primeras_participaciones = ::Kpi::Clases.estadistica_extern.constantize.primera_participacion_del_usuario
      expect(primeras_participaciones.ultima_semana.pluck(:usuario_id)).to eq([id_usuario_nuevo])
    end
  end
end
