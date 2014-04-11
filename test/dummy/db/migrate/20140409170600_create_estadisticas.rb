class CreateEstadisticas < ActiveRecord::Migration
  def change
    create_table :estadisticas do |t|
      t.integer :usuario_id
      t.integer :subtipo_id

      t.timestamps
    end
    add_index :estadisticas, [:usuario_id, :subtipo_id], unique: true
  end
end
