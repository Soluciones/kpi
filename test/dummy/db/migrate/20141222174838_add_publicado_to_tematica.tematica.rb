# This migration comes from tematica (originally 20140609095223)
class AddPublicadoToTematica < ActiveRecord::Migration
  def change
    add_column :tematica_tematicas, :publicado, :boolean, default: true
  end
end
