class CreateTematicaTematizaciones < ActiveRecord::Migration
  def change
    create_table :tematica_tematizaciones do |t|
      t.integer :tematizable_id, null: false
      t.string :tematizable_type, null: false
      t.string :tematizable_grupo, null: false, default: '' # Lo usaremos para más detalles, p.ej. en contenidos guardaremos la clase, en usuario si es experto...  - Hay que predeterminar NOT NULL para que la clave única funcione
      t.integer :tematica_id, null: false
      t.boolean :explicita

      t.timestamps
    end
    add_index :tematica_tematizaciones, [:tematizable_type, :tematizable_id], name: 'ix_tematizaciones_by_tematizable'
    add_index :tematica_tematizaciones, [:tematica_id, :tematizable_type, :tematizable_grupo, :tematizable_id], name: 'ix_tematizaciones_by_tematica_and_type_grupo', unique: true
  end
end
