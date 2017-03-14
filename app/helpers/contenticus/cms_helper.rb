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
    object.fields[identifier.to_s].html_safe
  end

  def cms_image(identifier, object)
    image = object.fields[identifier.to_s]
    image_id = image["image_id"]
    if Contenticus::Image.exists?(image["image_id"])
      file = Contenticus::Image.find(image["image_id"])
      image_tag file.file.thumb(crop_command(image)).url, alt: crop_command(image)
    end
  end

  private

  def crop_command(image)
    "%ix%i+%i+%i" % [image['crop_w'], image['crop_h'], image['crop_x'], image['crop_y']].map(&:to_i)
  end

end
