class CreateLayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :layouts do |t|
    	t.integer :project_id
    	t.integer :size
    	t.string :plan
      t.timestamps
    end
  end
end
