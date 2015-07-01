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
      render "contenticus/admin/images/image_fields", form: form, name: name
    end
  end

end
