class CreateCms < ActiveRecord::Migration
  
  def self.up
    
    # -- Pages --------------------------------------------------------------
    create_table :contenticus_pages do |t|
      t.string  :layout
      t.string  :ancestry
      t.integer :target_page_id
      t.integer :main_locale_id      
      t.string  :locale
      t.string  :label,           null: false
      t.string  :slug
      t.string  :old_paths,       array: true, default: []
      t.string  :full_path,       null: false
      t.integer :position,        null: false, default: 0
      t.boolean :is_published,    null: false, default: true
      t.timestamps
    end
    add_index :contenticus_pages, :full_path, unique: true
    add_index :contenticus_pages, :ancestry
    
    # -- Blocks -----------------------------------------------------------
    create_table :contenticus_blocks do |t|
      t.references :sectionable,  polymorphic: true
      t.string  :layout
      t.string  :section
      t.jsonb   :fields,          null: false, default: '{}'
      t.integer :position,        null: false, default: 0
      t.boolean :is_published,    null: false, default: true
      t.timestamps
    end
    add_index :contenticus_blocks, :sectionable_id 
    add_index :contenticus_blocks, [:sectionable_id, :sectionable_type] 

    # -- Snippets ----------------------------------------------------------
    create_table :contenticus_snippets do |t|
      t.string  :layout
      t.integer :main_locale_id      
      t.string  :locale
      t.string  :label,           null: false
      t.string  :slug
      t.integer :position,        null: false, default: 0
      t.boolean :is_published,    null: false, default: true
      t.timestamps
    end
    add_index :contenticus_snippets, :position    
 
  end
  
  def self.down
    drop_table :contenticus_pages
    drop_table :contenticus_blocks
    drop_table :contenticus_snippets
  end

end

