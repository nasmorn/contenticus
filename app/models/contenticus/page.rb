class Contenticus::Page < ActiveRecord::Base
  self.table_name = "contenticus_pages"

  has_ancestry

  # Relationships
  has_one :master_block, -> { where(section: "master") }, class: Contenticus::Block, foreign_key: :sectionable_id

end