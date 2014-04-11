class AddBlogIdIdToContenido < ActiveRecord::Migration
  def change
    add_column :contenidos, :blog_id, :integer
  end
end
