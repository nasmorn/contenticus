class CreateImages < ActiveRecord::Migration[4.2]
  def change
    create_table :contenticus_images do |t|
      t.references :block
      t.string :file_uid
      t.string :file_name
      t.integer :file_width
      t.integer :file_height
      t.integer :file_size
      t.timestamps
    end
  end
end
