# This migration comes from tematica (originally 20140213123349)
class AddPortadaPathToTematica < ActiveRecord::Migration
  def change
    add_column :tematica_tematicas, :portada_path, :string, after: 'nombre'
  end
end
