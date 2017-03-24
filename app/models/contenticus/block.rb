class Contenticus::Block < ActiveRecord::Base
  self.table_name = "contenticus_blocks"

  serialize :fields, JsonSerializer

  # Relationships
  belongs_to :blockable, polymorphic: true

  # Validations
  validates_presence_of :layout

  # Scopes
  scope :master, -> {where(section: nil)}

  # Instance Methods

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