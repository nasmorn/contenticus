module Contenticus::CmsHelper

  def cms(key, different_block: nil)
    block = different_block || @block
    render block.tag(key).frontend_partial, tag: block.tag(key)
  end

  def cms_block(block, view = "main")
    render partial: "contenticus/layouts/blocks/#{block.layout}/#{view}", locals: {block: block}
  end

  def cms_section(identifier, object, view = "main")
  end

end
