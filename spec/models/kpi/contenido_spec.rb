# coding: UTF-8

require 'spec_helper'

describe Contenido do
  describe "scopes" do
    let!(:nuestro_guru) do
      FactoryGirl.create(:usuario, estado_id: Usuario::ESTADO_USUARIO_ADMIN) do |usuario|
        FactoryGirl.create(:tematizacion_usuario_experto, tematizable_id: usuario.id)
        FactoryGirl.create(:contenido, created_at: 2.days.ago, usuario: usuario)
        FactoryGirl.create(:contenido, created_at: 2.years.ago, usuario: usuario)
      end
    end
    let!(:un_guru_externo) do
      FactoryGirl.create(:usuario, estado_id: Usuario::ESTADO_USUARIO_NORMAL) do |usuario|
        FactoryGirl.create(:tematizacion_usuario_experto, tematizable_id: usuario.id)
        FactoryGirl.create_list(:contenido, 3, created_at: 2.days.ago, usuario_id: usuario.id)
      end
    end
    let!(:un_forero) do
      FactoryGirl.create(:usuario, estado_id: Usuario::ESTADO_USUARIO_NORMAL) do |usuario|
        FactoryGirl.create_list(:contenido, 2, created_at: 2.days.ago, usuario: usuario)
      end
    end

    context "en la última semana" do
      it "filtra los mensajes de admin" do
        mensajes = Contenido.autor_admin.ultima_semana
        mensajes.should have(1).mensaje
        mensajes.map(&:usuario_id).should == [nuestro_guru.id]
      end

      it "filtra los mensajes de no admin" do
        mensajes = Contenido.autor_no_admin.ultima_semana
        mensajes.should have(5).mensajes
        mensajes.map(&:usuario_id).should_not include(nuestro_guru.id)
      end

      it "filtra los mensajes de usuarios normales (No Admin ni Experto)" do
        mensajes = Contenido.autor_ni_admin_ni_experto.ultima_semana
        mensajes.should have(2).mensajes
        mensajes.map(&:usuario_id).uniq.should == [un_forero.id]
      end
    end

    context "totales" do
      it "filtra los mensajes de admin" do
        mensajes = Contenido.autor_admin
        mensajes.should have(2).mensajes
        mensajes.map(&:usuario_id).uniq.should == [nuestro_guru.id]
      end

      it "filtra los mensajes de expertos" do
        mensajes = Contenido.autor_experto.all
        mensajes.should have(3).mensajes
        mensajes.map(&:usuario_id).uniq.should == [un_guru_externo.id]
      end
    end
  end
end
