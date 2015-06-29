module Contenticus::CmsAdminHelper

  def field_for_tag(form, name, options)
    if options[:type] == "cms_field"
      form.text_field "field_#{name}"
    elsif options[:type] == "cms_section"
      render "contenticus/admin/pages/section_fields", form: form, name: name
    elsif options[:type] == "cms_rich_text"
      form.text_area "field_#{name}", class: "rich-text-editor"
    end
  end

end
