class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
    	t.string :unit_no
    	t.float	 :net_value
    	t.integer	:model_id
    	t.integer :layout_id
    	t.integer :project_id
    	t.integer :user_id
      t.timestamps
    end
  end
end
