module Contenticus::CmsAdminHelper

  def field_for_tag(form, tag)
    case tag.type
    when "text_field"
      render "contenticus/admin/tags/text_field", form: form, tag: tag
    when "section"
      render "contenticus/admin/tags/section_fields", form: form, tag: tag
    when "image_field"
      render "contenticus/admin/tags/image_field", form: form, tag: tag
    when "select"
      render "contenticus/admin/tags/select", form: form, tag: tag
    when "url"
      render "contenticus/admin/tags/url", form: form, tag: tag
    else
      raise tag.type
    end
  end

end
