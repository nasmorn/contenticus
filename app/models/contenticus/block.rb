class Contenticus::Block < ActiveRecord::Base
  self.table_name = "contenticus_blocks"

  serialize :fields, JsonSerializer

  # Relationships
  belongs_to :sectionable, polymorphic: true
  has_many :blocks, as: :sectionable, dependent: :destroy

  # Validations
  validates_presence_of :layout, :section

  def tags
    @tags ||= get_layout.tags
  end

  def tag(key)
    tags.find {|tag| tag.key == key.to_s}
  end

  def get_layout
    Contenticus::Layout.new(layout, fields)
  end

  def published?
    is_published
  end

end