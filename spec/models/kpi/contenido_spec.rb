require 'spec_helper'

describe Contenido do
  let(:clase_contenido) { ::Kpi::Clases.contenido_extern.constantize }

  describe 'scopes de autores y tipos de autor' do
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

    context 'en la última semana' do
      it 'filtra los mensajes de admin' do
        mensajes = clase_contenido.autor_admin.ultima_semana
        expect(mensajes.size).to eq(1)
        expect(mensajes.map(&:usuario_id)).to eq([nuestro_guru.id])
      end

      it 'filtra los mensajes de no admin' do
        mensajes = clase_contenido.autor_no_admin.ultima_semana
        expect(mensajes.size).to eq(5)
        expect(mensajes.map(&:usuario_id)).not_to include(nuestro_guru.id)
      end

      it 'filtra los mensajes de usuarios normales (No Admin ni Experto)' do
        mensajes = clase_contenido.autor_ni_admin_ni_experto.ultima_semana
        expect(mensajes.size).to eq(2)
        expect(mensajes.map(&:usuario_id).uniq).to eq([un_forero.id])
      end

      it 'cuenta el total de autores' do
        expect(clase_contenido.autores.ultima_semana.count).to eq(3)
      end
    end

    context 'totales' do
      it 'filtra los mensajes de admin' do
        mensajes = clase_contenido.autor_admin
        expect(mensajes.size).to eq(2)
        expect(mensajes.map(&:usuario_id).uniq).to eq([nuestro_guru.id])
      end

      it 'filtra los mensajes de expertos' do
        mensajes = clase_contenido.autor_experto.all
        expect(mensajes.size).to eq(3)
        expect(mensajes.map(&:usuario_id).uniq).to eq([un_guru_externo.id])
      end
    end
  end

  describe 'scopes de tipos de contenido' do
    context 'filtra los mensajes de foros' do
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

      it 'todos' do
        expect(clase_contenido.en_foros.count).to eq(5)
        expect(clase_contenido.en_foros.ultima_semana.count).to eq(4)
      end

      it 'sólo de admins' do
        expect(clase_contenido.en_foros.autor_admin.count).to eq(2)
      end

      it 'sólo nuevos hilos' do
        expect(clase_contenido.hilos.count).to eq(3)
        expect(clase_contenido.hilos.ultima_semana.count).to eq(2)
      end

      it 'sólo respuestas' do
        expect(clase_contenido.respuestas.count).to eq(2)
      end
    end

    context 'filtra los mensajes de blogs' do
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

      it 'todos' do
        expect(clase_contenido.en_blogs.count).to eq(5)
        expect(clase_contenido.en_blogs.ultima_semana.count).to eq(4)
      end

      it 'sólo de admins' do
        expect(clase_contenido.en_blogs.autor_admin.count).to eq(2)
      end

      it 'sólo posts' do
        expect(clase_contenido.posts.count).to eq(3)
        expect(clase_contenido.posts.ultima_semana.count).to eq(2)
      end

      it 'sólo respuestas' do
        expect(clase_contenido.comentarios_a_posts.count).to eq(2)
      end
    end
  end
end
