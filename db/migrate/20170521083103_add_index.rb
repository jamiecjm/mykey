class AddIndex < ActiveRecord::Migration[5.0]
  def change
  	add_index :layouts, :project_id
  	add_index :models, :project_id
  	add_index :units, :project_id
  	add_index :units, :layout_id
  	add_index :units, :model_id
  	add_index :units, :user_id
  end
end
