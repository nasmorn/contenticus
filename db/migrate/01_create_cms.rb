class CreateCms < ActiveRecord::Migration

  def self.up

    # -- Slug ---------------------------------------------------------------
    create_table :contenticus_slugs do |t|
      t.references :sluggable,   polymorphic: true
      t.string :ancestry
      t.integer :position,       null: false, default: 0
      t.string :label,           null: false
      t.string :slug,            null: false
      t.string :full_path,       null: false
      t.string :old_paths,       array: true, default: []
      t.string :domain
      t.timestamps
    end

    add_index :contenticus_slugs, [:sluggable_id, :sluggable_type]
    add_index :contenticus_slugs, [:full_path, :domain], unique: true
    add_index :contenticus_slugs, :ancestry

    # -- Pages --------------------------------------------------------------
    create_table :contenticus_pages do |t|
      t.integer :target_page_id
      t.timestamps
    end

    # -- Blocks -----------------------------------------------------------
    create_table :contenticus_blocks do |t|
      t.references :sectionable,  polymorphic: true, null: false
      t.string  :layout
      t.string  :section
      t.jsonb   :fields,          null: false, default: '{}'
      t.boolean :is_published,    null: false, default: true
      t.timestamps
    end
    add_index :contenticus_blocks, :sectionable_id
    add_index :contenticus_blocks, [:sectionable_id, :sectionable_type]

    # -- Snippets -----------------------------------------------------------
    create_table :contenticus_snippets do |t|
      t.string :label, null: false
      t.string :key, null: false
      t.text   :comment
      t.timestamps
    end

    add_index :contenticus_snippets, :key, unique: true
    add_index :contenticus_snippets, :label, unique: true
  end

  def self.down
    drop_table :contenticus_slugs
    drop_table :contenticus_pages
    drop_table :contenticus_blocks
    drop_table :contenticus_snippets
  end

end

