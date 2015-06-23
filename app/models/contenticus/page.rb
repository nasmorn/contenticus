class Contenticus::Page < ActiveRecord::Base
  self.table_name = "contenticus_pages"

  # Relationships
  has_one :master_block, -> { where(section: "master") }, class_name: Contenticus::Block, foreign_key: :sectionable_id
  accepts_nested_attributes_for :master_block

  has_one :slug, as: :sluggable
  accepts_nested_attributes_for :slug

  def self.options_for_select(current_page)
    options = []
    ::Contenticus::Slug.includes(:sluggable).arrange.each do |k,v|
      option_for_select k, v, options, 0, current_page
    end
    options
  end 

  def self.option_for_select(slug, children, options, depth, current_page)
    return if current_page.id == slug.sluggable.id
    options << [(".." * depth) + " " + slug.label, slug.id]
    children.each do |k,v|
      option_for_select k, v, options, depth + 1, current_page
    end
  end

end