module Contenticus::CmsAdminHelper

  def field_for_tag(form, tag)
    render "contenticus/admin/tags/#{tag.type}", form: form, tag: tag
  end

  def image_block_options
    Contenticus::Block.all.map do |block|
      [block.blockable.try(:label), block.id]
    end
  end

  def image_field_options(block)
    Contenticus::Image.where(block: block).pluck(:file_name, :id) + Contenticus::Image.where(block: nil).pluck(:file_name, :id).map {|i| ['General ' + i.first, i.last]}
  end

  def pages_for_select(selected_key)
    frontpage = Contenticus::Slug.find_by(ancestry: nil)
    groups = frontpage.children.map do |first|
      [
        first.label,
        [[first.label + " (#{first.full_path})", first.id]] + flatten_nested_hash(first.descendants.arrange(order: 'position')).map {|c| [c.label + " (#{c.full_path})", c.id]}
      ]
    end

    grouped_options_for_select(
      groups,
      selected_key)
  end

  def flatten_nested_hash(categories)
    categories.flat_map{|k, v| [k, *flatten_nested_hash(v)]}
  end
end
