class CreateKpiSemanales < ActiveRecord::Migration
  def change
    create_table :kpi_semanales do |t|
      t.integer :anyo
      t.integer :semana
      t.string :modelo
      t.string :scope
      t.integer :dato

      t.timestamps
    end
    add_index :kpi_semanales, [:modelo, :scope, :anyo, :semana], unique: true
    add_index :kpi_semanales, [:anyo, :semana]
  end
end
