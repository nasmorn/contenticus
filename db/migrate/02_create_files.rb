class CreateFiles < ActiveRecord::Migration
  def change
    create_table :contenticus_files do |t|
      t.references :block
      t.string :file_uid
      t.string :file_name
      t.timestamps
    end
  end
end
