class Contenticus::Block < ActiveRecord::Base
  self.table_name = "contenticus_blocks"

  LOCALES = ["de", "en"]

  # Relationships
  belongs_to :sectionable, polymorphic: true
  has_many :blocks, as: :sectionable
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

  def field_names
    get_layout.tags.keys
  end

  def tags
    get_layout.tags
  end

  def section_blocks(identifier)
    blocks.select {|b| b.section == identifier}.sort_by(&:position)
  end
  
  def method_missing(method_sym, *arguments, &block)
    method_name = method_sym.to_s
    return super unless method_name =~ /field_\w+/

    method_name.gsub!('field_', '')
    field_name = method_name.gsub('=', '')

    #return super unless field_names.include?(field_name)

    if method_name.chars.last == "="
      self.fields[field_name] = arguments.first
    else
      self.fields[field_name]
    end
  end

  def section_layouts
    ['col_2', 'list', 'ul']
  end

  def master?
    section == "master"
  end

  def get_layout
    Contenticus::Block.get_layout(layout, section == "master")
  end

  def self.get_layout(layout, master)
    if master
      Contenticus::PageLayout.new(layout)
    else
      Contenticus::BlockLayout.new(layout)
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