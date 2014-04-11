class AddInicialIdToContenido < ActiveRecord::Migration
  def change
    add_column :contenidos, :inicial_id, :integer
  end
end
