class Contenticus::Page < ActiveRecord::Base
  self.table_name = "contenticus_pages"

  # Relationships
  has_one :block, -> { master }, as: :blockable, class_name: Contenticus::Block
  has_one :meta, -> { section('meta') }, as: :blockable, class_name: Contenticus::Block
  has_one :slug, as: :sluggable, class_name: ::Contenticus::Slug, autosave: true

  def label
    slug.try(:label) || "no slug"
  end

  def redirect?
    block.layout == 'system/redirect'
  end

  def redirect_target
    if block.fields.has_key?('redirect')
      return Contenticus::Slug.find(block.fields['redirect']['value']).full_path
    else
      raise
    end
  rescue
    if slug.children.any?
      slug.children.first.full_path
    else
      "#"
    end
  end

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
