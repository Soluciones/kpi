# coding: UTF-8

require 'spec_helper'

describe Contenido do
  describe "scopes" do
    let!(:nuestro_guru) do
      FactoryGirl.create(:usuario, estado_id: Usuario::ESTADO_USUARIO_ADMIN) do
        usuario.tematizaciones << Tematica::Tematizaciones.create(tematizable_grupo:: Usuario::EXPERTO)
        usuario.contenidos << FactoryGirl.create(:contenido, created_at: 2.days.ago)
      end
    end

    context "en la última semana" do
      it "filtra los mensajes de moderador" do
        mensajes = Contenido.autor_moderador.ultima_semana
        mensajes.map(&:usuario_id).should == [nuestro_guru.id]
        mensajes.should have(1).mensaje
      end
    end

    context "totales" do
    end
  end
end
