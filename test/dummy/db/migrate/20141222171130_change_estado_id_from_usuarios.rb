class ChangeEstadoIdFromUsuarios < ActiveRecord::Migration
  def change
    change_column :usuarios, :estado_id, 'integer USING CAST(estado_id AS integer)'
  end
end
