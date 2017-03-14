class Contenticus::Block < ActiveRecord::Base
  self.table_name = "contenticus_blocks"

  LOCALES = ["de", "en"]

  serialize :fields, JsonSerializer

  # Relationships
  belongs_to :sectionable, polymorphic: true
  has_many :blocks, as: :sectionable, dependent: :destroy
  accepts_nested_attributes_for :blocks, allow_destroy: true

  # Callbacks
  before_validation :assign_locales
  validates_presence_of :layout, :section

  # Assign the locales of child block unless they are already set
  def assign_locales
    blocks.each do |block|
      block.locale ||= self.locale
    end
  end

  def tags
    get_layout.tags
  end

  def section_blocks(identifier)
    blocks.select {|b| b.section == identifier}.sort_by(&:position)
  end

  def section_layouts
    ['top-banner']
  end

  def master?
    section == "master"
  end

  def get_layout
    Contenticus::Block.get_layout(layout, self.fields, section == "master")
  end

  def self.get_layout(layout, fields, master)
    if master
      Contenticus::PageLayout.new(layout, fields)
    else
      Contenticus::BlockLayout.new(layout, fields)
    end
  end

  def self.from_layout(layout, master = false)
    block = self.new
    block.layout = layout
    block.section = "master" if master

    # # Create first block in sections
    # layout = get_layout(layout, master)
    # layout.tags.each do |name, options|
    #   if options[:type] == "cms_section"
    #     block.blocks << from_layout(name)
    #     block.blocks.last.section = name
    #   end
    # end

    return block
  end

end