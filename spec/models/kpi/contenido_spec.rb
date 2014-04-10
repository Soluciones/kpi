# coding: UTF-8

require 'spec_helper'

describe Contenido do
  let(:clase_contenido) { ::Kpi::Clases.contenido_extern.constantize }

  describe "scopes de autores y tipos de autor" do
    let!(:nuestro_guru) do
      FactoryGirl.create(:usuario_admin) do |usuario|
        FactoryGirl.create(:contenido, created_at: 2.days.ago, usuario: usuario)
        FactoryGirl.create(:contenido, created_at: 2.years.ago, usuario: usuario)
      end
    end
    let!(:un_guru_externo) do
      FactoryGirl.create(:usuario_experto) do |usuario|
        FactoryGirl.create_list(:contenido, 3, created_at: 2.days.ago, usuario_id: usuario.id)
      end
    end
    let!(:un_forero) do
      FactoryGirl.create(:usuario_normal) do |usuario|
        FactoryGirl.create_list(:contenido, 2, created_at: 2.days.ago, usuario: usuario)
      end
    end

    context "en la última semana" do
      it "filtra los mensajes de admin" do
        mensajes = clase_contenido.autor_admin.ultima_semana
        mensajes.should have(1).mensaje
        mensajes.map(&:usuario_id).should == [nuestro_guru.id]
      end

      it "filtra los mensajes de no admin" do
        mensajes = clase_contenido.autor_no_admin.ultima_semana
        mensajes.should have(5).mensajes
        mensajes.map(&:usuario_id).should_not include(nuestro_guru.id)
      end

      it "filtra los mensajes de usuarios normales (No Admin ni Experto)" do
        mensajes = clase_contenido.autor_ni_admin_ni_experto.ultima_semana
        mensajes.should have(2).mensajes
        mensajes.map(&:usuario_id).uniq.should == [un_forero.id]
      end

      it "cuenta el total de autores" do
        clase_contenido.autores.ultima_semana.count.should == 3
      end
    end

    context "totales" do
      it "filtra los mensajes de admin" do
        mensajes = clase_contenido.autor_admin
        mensajes.should have(2).mensajes
        mensajes.map(&:usuario_id).uniq.should == [nuestro_guru.id]
      end

      it "filtra los mensajes de expertos" do
        mensajes = clase_contenido.autor_experto.all
        mensajes.should have(3).mensajes
        mensajes.map(&:usuario_id).uniq.should == [un_guru_externo.id]
      end
    end
  end

  describe "scopes de tipos de contenido" do
    context "filtra los mensajes de foros" do
      let!(:nuestro_guru) do
        FactoryGirl.create(:usuario_admin) do |usuario|
          FactoryGirl.create(:respuesta_con_hilo, created_at: 2.days.ago, usuario: usuario)
          FactoryGirl.create(:post, created_at: 2.days.ago, usuario: usuario)
        end
      end
      let!(:un_forero) do
        FactoryGirl.create(:usuario_normal) do |usuario|
          FactoryGirl.create(:hilo, created_at: 1.year.ago, usuario: usuario)
          FactoryGirl.create(:respuesta_con_hilo, created_at: 2.days.ago, usuario: usuario)
        end
      end

      it "todos" do
        clase_contenido.en_foros.count.should == 5
        clase_contenido.en_foros.ultima_semana.count.should == 4
      end

      it "sólo de admins" do
        clase_contenido.en_foros.autor_admin.count.should == 2
      end

      it "sólo nuevos hilos" do
        clase_contenido.hilos.count.should == 3
        clase_contenido.hilos.ultima_semana.count.should == 2
      end

      it "sólo respuestas" do
        clase_contenido.respuestas.count.should == 2
      end
    end

    context "filtra los mensajes de blogs" do
      let!(:nuestro_guru) do
        FactoryGirl.create(:usuario_admin) do |usuario|
          FactoryGirl.create(:hilo, created_at: 2.days.ago, usuario: usuario)
          FactoryGirl.create(:comentario_con_post, created_at: 2.days.ago, usuario: usuario)
        end
      end
      let!(:un_guru_externo) do
        FactoryGirl.create(:usuario_experto) do |usuario|
          FactoryGirl.create(:post, created_at: 1.year.ago, usuario: usuario)
          FactoryGirl.create(:comentario_con_post, created_at: 2.days.ago, usuario: usuario)
        end
      end

      it "todos" do
        clase_contenido.en_blogs.count.should == 5
        clase_contenido.en_blogs.ultima_semana.count.should == 4
      end

      it "sólo de admins" do
        clase_contenido.en_blogs.autor_admin.count.should == 2
      end

      it "sólo posts" do
        clase_contenido.posts.count.should == 3
        clase_contenido.posts.ultima_semana.count.should == 2
      end

      it "sólo respuestas" do
        clase_contenido.comentarios_a_posts.count.should == 2
      end
    end
  end
end
