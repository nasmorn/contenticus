module Contenticus::CmsAdminHelper

  def field_for_tag(form, tag)
    render "contenticus/admin/tags/#{tag.type}", form: form, tag: tag
  end

  def image_block_options
    Contenticus::Block.all.map do |block|
      name = case block.blockable_type
      when 'Contenticus::Page' then block.blockable.slug.label
      when 'Contenticus::Snippet' then block.blockable.label
      end
      [name, block.id]
    end
  end

  def image_field_options(block)
    Contenticus::Image.where(block: block).pluck(:file_name, :id) + Contenticus::Image.where(block: nil).pluck(:file_name, :id).map {|i| ['General ' + i.first, i.last]}
  end

end
