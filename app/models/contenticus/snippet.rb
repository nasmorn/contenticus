class Contenticus::Snippet < ActiveRecord::Base
  self.table_name = "contenticus_snippets"

  # Relationships
  has_one :block, -> { where(section: "snippet") }, as: :sectionable, class_name: Contenticus::Block

end