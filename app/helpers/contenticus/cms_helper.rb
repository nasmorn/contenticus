module Contenticus::CmsHelper

  def cms(key, different_block: nil)
    block = different_block || @block
    tag = block.tag(key)
    raise "Tag with key '#{key}' not found in block #{block.id} with layout '#{block.layout}'" unless tag
    render tag.frontend_partial, tag: tag
  end

  def cms_section(identifier, object, view = "main")
  end

end
