module Contenticus::CmsAdminHelper

  def field_for_tag(form, tag)
    render "contenticus/admin/tags/#{tag.type}", form: form, tag: tag
  end

  def image_block_options
    Contenticus::Block.all.map do |block|
      [block.blockable.try(:label), block.id]
    end
  end

  def image_field_options(block, min_size_w: nil, min_size_h: nil)
    scope = Contenticus::Image.where(block: [block, nil])
    scope = scope.where("file_width >= ?", min_size_w) if min_size_w
    scope = scope.where("file_height >= ?", min_size_h) if min_size_h
    scope.order(:block_id, :file_name).select(:block_id, :file_name, :file_width, :file_height, :id).map do |image|
      [
        [image.block_id == block.id ? nil : 'General' ,image.file_name, [image.file_width, image.file_height].join("x")].compact.join(" - "),
        image.id
      ]
    end
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
