module Contenticus::CmsAdminHelper

  def field_for_tag(form, name, options)
    if options[:type] == "cms_field"
      form.text_field "field_#{name}"
    elsif options[:type] == "cms_section"
      render "contenticus/admin/pages/block_fields", form: form, name: name
    end
  end

end
