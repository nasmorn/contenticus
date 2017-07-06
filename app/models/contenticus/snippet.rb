class Contenticus::Snippet < ActiveRecord::Base
  self.table_name = "contenticus_snippets"

  # Relationships
  has_one :block, -> { master }, as: :blockable, class_name: Contenticus::Block

  def contenticus_label
    label
  end

end
