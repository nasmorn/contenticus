class CreateImages < ActiveRecord::Migration
  def change
    create_table :contenticus_images do |t|
      t.references :block
      t.string :file_uid
      t.string :file_name
      t.integer :width
      t.integer :height
      t.timestamps
    end
  end
end
