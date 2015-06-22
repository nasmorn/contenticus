class Contenticus::Page < ActiveRecord::Base
  self.table_name = "contenticus_pages"

  # Relationships
  has_one :master_block, -> { where(section: "master") }, class_name: Contenticus::Block, foreign_key: :sectionable_id
  accepts_nested_attributes_for :master_block

  has_one :slug, as: :sluggable
  accepts_nested_attributes_for :slug

end