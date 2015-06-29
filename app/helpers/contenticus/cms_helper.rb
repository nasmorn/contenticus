module Contenticus::CmsHelper

  def cms_block(block, view = "main")
    render partial: "contenticus/layouts/blocks/#{block.layout}/#{view}", locals: {block: block}
  end

  def cms_section(identifier, object, view = "main")
    object.section_blocks(identifier).collect do |block|
      cms_block(block, view)
    end.join.html_safe
  end

  def cms_field(identifier, object)
    object.fields[identifier.to_s]
  end

  def cms_rich_text(identifier, object)
    object.fields[identifier.to_s]
  end

end
