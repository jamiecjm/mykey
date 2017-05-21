class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
    	t.text	 	:description
    	t.integer	:album_id
    	t.string	:picture
      t.timestamps
    end
    add_index :pictures, :album_id
  end
end
