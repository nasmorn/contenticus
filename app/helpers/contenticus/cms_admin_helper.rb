module Contenticus::CmsAdminHelper

  def field_for_tag(form, name, options)
    case options[:type]
    when "cms_field"
      form.text_field "field_#{name}"
    when "cms_section"
      render "contenticus/admin/pages/section_fields", form: form, name: name
    when "cms_rich_text"
      form.text_area "field_#{name}", class: "rich-text-editor"
    when "cms_image"
      aspect = options.fetch(:aspect, "4:3").split(":").map(&:to_f)
      min_size = options.fetch(:min_size, "0x0")
      render "contenticus/admin/images/image_fields", form: form, name: name, aspect: aspect, min_size: min_size
    end
  end

end
