module Contenticus::CmsHelper

  def cms(key, block: @block, collectible_layout: nil, layout: nil, position: nil, &wrapper)
    tag = block.tag(key)
    raise "Tag with key '#{key}' not found in block #{block.id} with layout '#{block.layout}'" unless tag

    return unless tag.published?

    # Set default layout for collections
    layout ||= tag.collection_layout unless block_given? || !tag.respond_to?(:collection_layout)
    # For layout try rendering - default layout might not exist
    if layout
      begin
        return render partial: tag.frontend_partial, layout: layout, locals: {tag: tag, collectible_layout: collectible_layout}
      rescue
      end
    end

    content = render tag.frontend_partial, tag: tag, collectible_layout: collectible_layout, position: position

    # Use content of the block to wrap the call to cms
    # this allows us to not render this content if published is set to false
    if block_given?
      content_for key do
        content
      end
      wrapper.call
      nil
    else
      content
    end
  rescue
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
    render @block.frontend_partial, block: @block
  end

  def cms_meta
    @meta || Contenticus::Meta.new
  end

end
