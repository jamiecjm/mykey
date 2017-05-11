class CreateModels < ActiveRecord::Migration[5.0]
  def change
    create_table :models do |t|
    	t.string :package
    	t.integer :project_id
      t.timestamps
    end
  end
end
