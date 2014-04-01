class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nick
      t.string :estado_id

      t.timestamps
    end
  end
end
