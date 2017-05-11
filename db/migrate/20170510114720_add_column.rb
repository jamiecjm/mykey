class AddColumn < ActiveRecord::Migration[5.0]
  def change
  	add_column :layouts, :pictures, :json
  end
end
