module Contenticus::CmsHelper

  def cms(key, block: @block, collectible_layout: nil, layout: nil)
    tag = block.tag(key)
    raise "Tag with key '#{key}' not found in block #{block.id} with layout '#{block.layout}'" unless tag
    if layout
      render partial: tag.frontend_partial, layout: layout, locals: {tag: tag}
    else
      render tag.frontend_partial, tag: tag, collectible_layout: collectible_layout
    end
  end

  def cms_tag(key, block: @block)
    tag = block.tag(key)
    raise "Tag with key '#{key}' not found in block #{block.inspect} with layout '#{block.layout}'" unless tag
    return tag
  end

  def cms_snippet(key)
    Contenticus::Snippet.find_by(key: key)
  end

  def cms_snippet_render(key)
    @block = cms_snippet(key).block
    render @block.frontend_partial
  end

end
