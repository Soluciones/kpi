class CreateContenidos < ActiveRecord::Migration
  def change
    create_table :contenidos do |t|
      t.string :titulo
      t.integer :usuario_id
      t.integer :subtipo_id
      t.integer :tema
      t.boolean :publicado

      t.timestamps
    end
  end
end
